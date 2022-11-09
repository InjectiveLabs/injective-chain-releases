#!/bin/bash

# MSG
MSG_BACKUP_START="Starting backup..."
MSG_AWS_CLI="AWS CLI is not installed, please follow the installation guide https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html"
MSG_INJD="Injectived not installed, please run the node_create.sh script first then run this script again"
MSG_SYNC_START="🔥 Starting sync process...🔥"
MSG_SYNC_SUCCESS="Syncing Successful, wait for some time to let your node catch up."
MSG_SYN_FAILED="Sync Failed"
MSG_NOTE="NOTE: By applying this snapshot, you trust that the provided blockchain history by Injective Labs is genuine."
TOOLS=("aws" "injectived" "jq" "tr" "liblz4-tool" "aria2" "curl")
WAIT_TIMEOUT=600
# Turn on debug mode
#set -x

check_tools() {
  INC_TOOLS=false
  for TOOL in ${TOOLS[@]}; do
    command -v $TOOL >/dev/null || {
      case "$TOOL" in
      "aws")
        echo $MSG_AWS_CLI
        INC_TOOLS=true
        ;;
      "injectived")
        echo $MSG_INJD
        INC_TOOLS=true
        ;;
      *)
        echo "$TOOL not installed, kindly install it and run this script again"
        INC_TOOLS=true
        ;;
      esac
    }
  done
  [[ $INC_TOOLS == "true" ]] && exit 1
  killall injectived &>/dev/null || true
}

injectived_backup() {
  echo $MSG_BACKUP_START
  mkdir -p $HOME/injectived-backup/
  cp -rf $HOME/.injectived/config $HOME/.injectived/keyring-file $HOME/injectived-backup/
}

injectived_sync() {
  echo $MSG_SYNC_START
  mkdir temp && cd temp
  URL=$(curl -L https://quicksync.io/injective.json | jq -r '.[] |select(.file=="injective-1-pruned")|.url')
  aria2c -x5 $URL
  lz4 -d $(basename $URL) | tar xf - -C $HOME/.injectived
  cd .. && rm -rf temp
}

injectived_restart() {
  injectived version
  injectived start
}

injectived_wait() {
  timeout $WAIT_TIMEOUT bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://localhost:26657/health)" != "200" ]]; do sleep 5; done' || {
    echo "Chain readiness probe exceeded timeout"
    exit 1
  }
}

injectived_healthcheck() {
  COUNT=0
  while true; do
    [[ $COUNT -lt 5 ]] || break
    LAST_HEIGHT=$(curl -sS http://localhost:26657/block | jq .result.block.header.height | tr -d '"')
    sleep 5
    CUR_HEIGHT=$(curl -sS http://localhost:26657/block | jq .result.block.header.height | tr -d '"')
    if [[ $LAST_HEIGHT -lt $CUR_HEIGHT ]]; then
      COUNT=$((COUNT + 1))
    else
      echo $MSG_SYNC_FAILED
      exit 1
    fi
  done
  echo $MSG_SYNC_SUCCESS
}

injectived_start_sync() {
  #Step1: Check if all required tools are installed - show what tools are missing
  check_tools
  #Step2: Backup config
  injectived_backup
  #Step3: Sync injectived snapshot from AWS bucket
  injectived_sync
  #Step4: Restart
  injectived_restart
  #Step5: Wait for injectived to be ready
  injectived_wait
  #Step6: Healthcheck compare block height, to make sure we synced successfuly
  injectived_healthcheck
}

injectived_sync_note() {
  echo $MSG_NOTE
  read -p "Continue (Y/N)?" choice
  case "$choice" in
  y | Y) injectived_start_sync ;;
  n | N) exit ;;
  *) echo "Invalid Choice" ;;
  esac
}

injectived_sync_note
