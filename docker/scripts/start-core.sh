#script for initializing an alpine container with an injective release
install_tools() {
  apk update && apk upgrade
  apk add --no-cache wget zip gcompat libgcc
}

get_latest_binary() {
  wget $GIT_RELEASE_REPO/$GIT_TAG/$RELEASE_ARCH
  unzip -o $RELEASE_ARCH
  mv -f injectived peggo injective-exchange /usr/bin
  mv -f libwasmvm.x86_64.so /usr/lib
}

injectived_set_working_dir() {
  mkdir -p $HOME/.injectived-artifacts
  cd $HOME/.injectived-artifacts
}

injectived_clean_working_dir() {
  rm -rf $HOME/.injectived-artifacts
  echo "### Provisioning Finished. Cleaning... ###"
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

start_core() {
  ulimit -n 120000
  yes 12345678 | injectived \
    --log-level=$LOG_LEVEL \
    --rpc.laddr "tcp://0.0.0.0:26657" \
    --statsd-address=statsd.injective.dev:8125 \
    --statsd-enabled=true \
    start
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

  install_tools
  injectived_set_working_dir
  get_latest_binary
  injectived_clean_working_dir
  start_core
}
injectived_start
