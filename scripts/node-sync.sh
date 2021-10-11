#!/bin/sh

#CHAIN sync height
CHAIN_SYNC_HEIGH=2000000
# MSG
MSG_BACKUP_START="Starting backup..."
MSG_AWS_CLI="AWS CLI not Installed, please follow the installation guide https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html"
MSG_SYNC_START="🔥 Starting sync process...🔥"
MSG_SYNC_SUCCESS="Syncing Successful, wait for some time to let your node catching up."
MSG_SYN_FAILD="Sync Faild"
MSG_NOTE="NOTE: By applying this snapshot, you trust Injective Labs provided blockchain history being genuine."

# Turn on debug mode
#set -x

command_exists() {
    # Check if command exists and fail otherwise
    if hash $1 2> /dev/null; then
        echo $2
        exit
    fi
}

aws_cli_exists() {
  command_exists "aws --version" $MSG_AWS_CLI
}

injectived_exists() {
    command_exists "injectived version" $MSG_NEW_NODE
    # Stop all running processes
    killall injectived &>/dev/null || true
}

injectived_backup() {
  echo $MSG_BACKUP_START
  mkdir -p $HOME/injectived-backup/
  cp -rf $HOME/.injectived/config $HOME/.injectived/keyring-file $HOME/injectived-backup/
}

injectived_sync() {
  echo $MSG_SYNC_START
  aws s3 sync --no-sign-request --delete s3://injective-snapshots/mainnet/injectived/data  ~/.injectived/data
}

injectived_restart() {
  injectived version
  injectived start
  #TODO: Update binary if required
}

injectived_healthcheck() {
  # check if it's syncing from height > 2000000
  height = curl localhost:26657/status | grep height
  if height > $CHAIN_SYNC_HEIGH; then
    $MSG_SYNC_SUCCESS
  else
    echo $MSG_SYN_FAILD
  fi
}


injectived_start_sync() {
  # Step1: Check if injectived exits
  injectived_exists
  # Step2: Backup config
  injectived_backup
  #Step3: Check if aws cli exists
  aws_cli_exists
  #Step4: Sync injectived snapshot from AWS bucket
  injectived_sync
  #Step5: Restart
  injectived_restart
  #Step6: Healthcheck compare block height, to make sure we synced successfuly
  injectived_healthcheck
}


injectived_sync_note() {
  echo $MSG_NOTE
  read -p "Continue (Y/N)?" choice
  case "$choice" in 
    y|Y ) injectived_start_sync;;
    n|N ) exit;;
    * ) echo "Invalid Choice";;
  esac
}

injectived_sync_note
