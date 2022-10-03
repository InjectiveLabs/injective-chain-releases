#!/bin/sh

GIT_TESTNET_TAG="v0.4.19-1656563866"
GIT_MAINNET_TAG="v1.4.0-1642928125"
GIT_INJ_ORG="https://github.com/InjectiveLabs"
GIT_NETWORK_CONFIG="mainnet-config"
GIT_RELEASE_REPO_MAINNET="https://github.com/InjectiveLabs/injective-chain-releases/releases/download"
GIT_RELEASE_REPO_TESTNET="https://github.com/InjectiveLabs/testnet/releases/download"
RELEASE_ARCH="linux-amd64.zip"
GIT_API_LATEST_RELEASE_MAINNET="https://api.github.com/repos/InjectiveLabs/injective-chain-releases/releases/latest"
GIT_API_LATEST_RELEASE_TESTNET="https://api.github.com/repos/InjectiveLabs/testnet/releases/latest"
MONIKER=""
MAIN_CHAIN_ID="injective-1"
MAINNET_CONFIG="mainnet-config"
MAINNET_CONFIG_LATEST="10001"
TESTNET_CONFIG_LATEST="corfu/70001"
TESTNET_CONFIG="testnet-config"
TEST_CHAIN_ID="injective-888"
NETWORK="mainnet"

MSG_NOTE="Please select the Injective Chain Network you want to join"
MSG_ENTER_MONIKER="Please enter moniker. # The argument <moniker> is the custom username of your node, it should be human-readable"

# It fetchs latest binary and move it to exec path
get_latest_binary() {
  wget $(printenv GIT_RELEASE_REPO_$(print $NETWORK))/$GIT_TAG/$RELEASE_ARCH
  unzip -o $RELEASE_ARCH
  mv -f injectived peggo injective-exchange /usr/bin
  mv -f libwasmvm.x86_64.so /usr/lib
}

# Init node
injectived_init_node() {
  # the Injective Chain has a chain-id of "injective-1"
  injectived init $MONIKER --chain-id $CHAIN_ID
}

injectived_configure() {
  git clone $GIT_INJ_ORG/$GIT_NETWORK_CONFIG

  # copy genesis file to config directory
  cp $GIT_NETWORK_CONFIG/$NETWORK_CONFIG_PATH/genesis.json $HOME/.injectived/config/genesis.json

  # copy config file to config directory
  cp $GIT_NETWORK_CONFIG/$NETWORK_CONFIG_PATH/app.toml $HOME/.injectived/config/app.toml
}

# Seed config with seeds node list
injectived_set_nodes() {
  NODES=$(cat $GIT_NETWORK_CONFIG/$NETWORK_CONFIG_PATH/seeds.txt | tr -s ' ' | cut -d ' ' -f 2 | tr '\n' ',' | sed 's/,$//')
  sed -i "/^\([[:space:]]*seeds = \).*/s//\1'"$NODES"'/" $HOME/.injectived/config/config.toml
}

injectived_set_working_dir() {
  mkdir -p $HOME/.injectived-artifacts
  cd $HOME/.injectived-artifacts
}

injectived_clean_working_dir() {
  rm -rf $HOME/.injectived-artifacts
}

injectived_moniker_input() {
  echo $MSG_ENTER_MONIKER
  read MONIKER
}

injectived_start_testnet() {
  export GIT_TAG=$GIT_TESTNET_TAG
  export GIT_NETWORK_CONFIG=$TESTNET_CONFIG
  export NETWORK_CONFIG_PATH=$TEST_NET_CONFIG_LATEST
  export CHAIN_ID=$TEST_CHAIN_ID
  export NETWORK="TESTNET"
  injectived_moniker_input
  injectived_set_working_dir
  get_latest_binary
  injectived_init_node
  injectived_configure
  injectived_set_nodes
  injectived_clean_working_dir
  injectived start
}

injectived_start_mainnet() {
  export GIT_TAG=$GIT_MAINNET_TAG
  export GIT_NETWORK_CONFIG=$MAINNET_CONFIG
  export NETWORK_CONFIG_PATH=$MAINNET_CONFIG_LATEST
  export CHAIN_ID=$MAIN_CHAIN_ID
  export NETWORK="MAINNET"
  injectived_moniker_input
  injectived_set_working_dir
  get_latest_binary
  injectived_init_node
  injectived_configure
  injectived_set_nodes
  injectived_clean_working_dir
  injectived start
}

injectived_start() {
  echo $MSG_NOTE
  read -p "Enter T for testnet OR M for mainnet (T/M)?" choice
  case "$choice" in
  t | T) injectived_start_testnet ;;
  m | M) injectived_start_mainnet ;;
  *) echo "Invalid Choice" ;;
  esac
}

injectived_start
