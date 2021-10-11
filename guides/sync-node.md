# Sync From Our Snapshot

Sync from a snapshot is the easiest/quickest way to sync the injective node.

Follow manual process [here.][sync-guide-link]

Or use automation [sync script](../scripts/README.md)

NOTE: You always have the option to sync your sentry from scratch via public sentries out there for a better decentralization factor.

# Sync From Scratch 


**NOTE:** Because of braking changes we made with release 10001 rc7, the sync process is done with
version 10001 rc6, until block N (will panic when it reaches block heigh N) than continuous with latest binary version 10001 rc7 to block N.

Here is a simple six steps guide on how to sync from scratch

### Step 1

Backup your configuration

```
mkdir $HOME/injectived-backup/
cp -rf $HOME/.injectived/config $HOME/.injectived/keyring-file $HOME/injectived-backup/
```

### Step 2
 Get previues release version `10001 rc6`
 ```
 # Make sure that no running injectived processes
 killall injectived &>/dev/null || true

 # If you are using systemd service to run injectived as a deamon, stop it.
 sudo systemctl stop injectived

 # Remove current binary that you use 
 rm -rf /usr/bin/injectived 

 wget https://github.com/InjectiveLabs/injective-chain-releases/releases/download/v1.0.1-1629427973/linux-amd64.zip
 unzip linux-amd64.zip
 mv -f injectived /usr/bin
 ```

### Step 3
Init chain
```

# The argument <moniker> is the custom username of your node. It should be human-readable.
export MONIKER=<moniker>

# the Injective Chain has a chain-id of "injective-1"
injectived init $MONIKER --chain-id injective-1
```

### Step 4 
Sync to specific block heigh
```
injectived start  --x-crisis-skip-assert-invariants
```

Wait until panic, block heigh will be XXX


### Step 5 
Switch binary back to latest version.

```
# Make sure that no running injectived processes
killall injectived &>/dev/null || true

# Remove old binary, you don't need it anymore
rm -rf /usr/bin/injectived 

# Get the latest one
wget https://github.com/InjectiveLabs/injective-chain-releases/releases/download/v1.0.1-1630308393/linux-amd64.zip
unzip linux-amd64.zip
sudo mv injectived peggo injective-exchange /usr/bin
```

### Step 6
Continue syncing to the latest block

```
injectived start  --x-crisis-skip-assert-invariants 
```

Wait until sync finish, and the block heigh should reach XXX. Follow via API

```
curl localhost:26657/status | grep height
```

When it reaches XXX block, your node is fully synced, and you are running the latest version of the injective chain.


[sync-guide-link]: https://docs.injective.network/docs/staking/mainnet/validate-on-mainnet/sync-from-snapshot/
