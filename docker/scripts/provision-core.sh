#!/bin/sh
set -e

# Install required tools
install_tools() {
  apt update && apt -y upgrade
  apt install -y wget jq zip git awscli liblz4-tool aria2 curl
}

# It fetchs latest binary and move it to exec path
get_latest_binary() {
  wget $GIT_RELEASE_REPO/$GIT_TAG/$RELEASE_ARCH
  unzip -o $RELEASE_ARCH
  mv -f injectived peggo /usr/bin
  mv -f libwasmvm.x86_64.so /usr/lib
}

# Init node
injectived_init_node() {
  injectived init $MONIKER --chain-id $CHAIN_ID --home $INJ_HOME --overwrite
}

injectived_configure() {
  git clone $GIT_INJ_ORG/$GIT_NETWORK_CONFIG

  # copy genesis file to config directory
  if [ "$NETWORK" = "testnet" ]; then
    aws s3 cp s3://injective-snapshots/testnet/genesis.json $INJ_HOME/config/genesis.json --no-sign-request
  else
    cp -f $GIT_NETWORK_CONFIG/$NETWORK_CONFIG_PATH/genesis.json $INJ_HOME/config/genesis.json
  fi

  # copy config file to config directory
  cp -f $GIT_NETWORK_CONFIG/$NETWORK_CONFIG_PATH/app.toml $INJ_HOME/config/app.toml
}

# Seed config with seeds node list
injectived_set_nodes() {
  if [ "$NETWORK" != "local" ]; then
    NODES=$(cat $GIT_NETWORK_CONFIG/$NETWORK_CONFIG_PATH/seeds.txt | tr -s ' ' | cut -d ' ' -f 2 | tr '\n' ',' | tr -d '"' | sed 's/,$//')
    if [ "$NETWORK" = "testnet" ]; then
      sed -i "/^\([[:space:]]*persistent_peers = \).*/s//\1'"$NODES"'/" $INJ_HOME/config/config.toml
    else
      sed -i "/^\([[:space:]]*seeds = \).*/s//\1'"$NODES"'/" $INJ_HOME/config/config.toml
    fi
  fi
}

injectived_set_working_dir() {
  mkdir -p $HOME/.injectived-artifacts
  cd $HOME/.injectived-artifacts
}

injectived_clean_working_dir() {
  chmod a+w $VOLUMES_PATH/dumps/* || true
  rm -rf $HOME/.injectived-artifacts
  echo "### Provisioning Finished. Cleaning... ###"
}

injectived_sync() {
  if is_sync_on $SYNC_CORE_SNAPSHOT; then
    echo "Sync injective core snapshot"
    if [ "$NETWORK" == "mainnet" ]; then
      SNAP=$(aws s3 ls --no-sign-request s3://injective-snapshots/mainnet/weekly/injectived/ | grep ".tar.lz4" | awk '{print $4}' | sort | head -n 1)
      aws s3 cp --no-sign-request s3://injective-snapshots/mainnet/weekly/injectived/$SNAP .
      lz4 -c -d $SNAP  | tar -x -C $INJ_HOME
    else
      aws s3 sync --no-sign-request --delete s3://injective-snapshots/$NETWORK/injectived/data $INJ_HOME/data
      aws s3 sync --no-sign-request --delete s3://injective-snapshots/$NETWORK/injectived/wasm $INJ_HOME/wasm
    fi
  fi
}

event_provider_sync() {
  if is_sync_on $SYNC_EVENT_PROVIDER_SNAPSHOT; then
    echo "Sync eventProvider snapshot"
    if [ "$NETWORK" == "mainnet" ]; then
      if [ "$SYNC_EVENT_PROVIDER_SNAPSHOT_TYPE" == "pruned" ]; then
        aws s3 cp --no-sign-request s3://injective-snapshots/$NETWORK/weekly/mongo/eventProviderV2Pruned $VOLUMES_PATH/dumps/eventProviderV2Pruned
      else
        aws s3 cp --no-sign-request s3://injective-snapshots/$NETWORK/mongo/eventProviderV2 $VOLUMES_PATH/dumps/eventProviderV2
      fi
    else
      aws s3 cp --no-sign-request s3://injective-snapshots/$NETWORK/daily/mongo/eventProviderV2 $VOLUMES_PATH/dumps/eventProviderV2
    fi
  fi
}

exchange_sync() {
  if is_sync_on $SYNC_EXCHANGE_SNAPSHOT; then
    echo "Sync exchange snapshot"
    if [ "$NETWORK" == "mainnet" ]; then
      aws s3 cp --no-sign-request s3://injective-snapshots/$NETWORK/weekly/mongo/exchangeV2 $VOLUMES_PATH/dumps/exchangeV2
    else
      aws s3 cp --no-sign-request s3://injective-snapshots/$NETWORK/daily/mongo/exchangeV2 $VOLUMES_PATH/dumps/exchangeV2
    fi
  fi
}

chronos_sync() {
  if is_sync_on $SYNC_CHRONOS_SNAPSHOT; then
    echo "Sync chronos snapshot"
    if [ "$NETWORK" == "mainnet" ]; then
      aws s3 --no-sign-request sync --delete s3://injective-snapshots/$NETWORK/weekly/chronos $VOLUMES_PATH/chronos
    else
      aws s3 --no-sign-request sync --delete s3://injective-snapshots/$NETWORK/daily/chronos $VOLUMES_PATH/chronos
    fi
  fi
}

explorer_sync() {
  if is_sync_on $SYNC_EXPLORER_SNAPSHOT; then
    echo "Sync explorer snapshot"
    if [ "$NETWORK" == "mainnet" ]; then
      aws s3 cp --no-sign-request s3://injective-snapshots/$NETWORK/weekly/mongo/explorerV2 $VOLUMES_PATH/dumps/explorerV2
    else
      aws s3 cp --no-sign-request s3://injective-snapshots/$NETWORK/daily/mongo/explorerV2 $VOLUMES_PATH/dumps/explorerV2
    fi
  fi
}

injectived_start_testnet() {
  export GIT_TAG=$GIT_TESTNET_TAG
  export GIT_NETWORK_CONFIG=$TESTNET_CONFIG
  export NETWORK_CONFIG_PATH=$TESTNET_CONFIG_LATEST
  export GIT_RELEASE_REPO=$GIT_RELEASE_REPO_TESTNET
}

injectived_start_mainnet() {
  export GIT_TAG=$GIT_MAINNET_TAG
  export GIT_NETWORK_CONFIG=$MAINNET_CONFIG
  export NETWORK_CONFIG_PATH=$MAINNET_CONFIG_LATEST
  export GIT_RELEASE_REPO=$GIT_RELEASE_REPO_MAINNET
}

is_sync_on() {
  SYNC_ON=$1
  if [ $SYNC_ON == true ]; then
    echo "Sync is on."
    #0=true
    return 0
  fi
  #1=false
  return 1
}

injectived_start() {
  if [ "$NETWORK" = "mainnet" ]; then
    echo "Provisioning Mainnet."
    injectived_start_mainnet
  elif [ "$NETWORK" = "testnet" ]; then
    echo "Provisioning Testnet."
    injectived_start_testnet
  elif [ "$NETWORK" = "local" ]; then
    echo "Provisioning local net should be done manually. Exiting"
    exit 1
  else
    echo "NETWORK env not set, exiting"
    exit 1
  fi
  # Setup artifacts
  install_tools
  injectived_set_working_dir
  get_latest_binary

  # Provision mainnet or testnet
  injectived_init_node
  injectived_configure
  injectived_set_nodes
  injectived_sync
  event_provider_sync
  exchange_sync
  chronos_sync
  explorer_sync
  injectived_clean_working_dir
}

injectived_start
