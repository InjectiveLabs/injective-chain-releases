# Sync From Our Snapshot

Sync from a snapshot is the easiest/quickest way to sync the injective node.

Follow manual process [here.][sync-guide-link]

Or use automation [sync script](../scripts/README.md)

**NOTE:**  You always have the option to sync your sentry from scratch via public sentries, which is a more decentralized approach.

# Sync From Scratch 


Because of breaking changes we made with release 10001 rc7, the node should be synced with `injectived`
version 10001 rc6, until halt height block 2045750. Then the `injectived` binary should be updated to version 10001 rc7 to the latest block.

Here is a simple 6-step guide on how to sync from scratch. 


### Step 1

Backup your configuration

```
mkdir $HOME/injectived-backup/
cp -rf $HOME/.injectived/config $HOME/.injectived/keyring-file $HOME/injectived-backup/
```

### Step 2
 Get the previous release version `10001 rc6`
 ```
 # Make sure that no running injectived processes
 killall injectived &>/dev/null || true
 
 # Remove current binary that you use 
 rm -rf /usr/bin/injectived 
 
 wget https://github.com/InjectiveLabs/injective-chain-releases/releases/download/v1.0.1-1629427973/linux-amd64.zip
 
 unzip linux-amd64.zip
 
 mv -f injectived /usr/bin
 
 #check version
 injectived version 
 
 # Should output
 #Version dev (48356b9)
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
Sync to halt height block
``` 
injectived start --halt-height 2045750
```

The node will automatically exit upon reaching block height reachs 2045750. 

**NOTE:** The sync process takes approximately two days until it reaches halt height. If you want to run sync as a background process, follow the official guide [using systemd service][using-systemd-guide-link].
**Make sure you update ExecStart commannd** bypassing `--halt-height 2045750` param.
 Otherwise, you will overshoot the halt height and will have to resync from scratch again.

`ExecStart=/bin/bash -c '/usr/bin/injectived  --halt-height 2045750 --log-level=error start'`


### Step 5 
From this step, given that you've now reached the halt height, you can now switch binary to the latest version.

```
# Make sure that no running injectived processes
killall injectived &>/dev/null || true

# If you use systemd service, stop it, otherwise skip this step
sudo systemctl stop injectived && sudo systemctl disable injectived

# Remove old binary, you don't need it anymore
rm -rf /usr/bin/injectived 

# Get the latest one
wget https://github.com/InjectiveLabs/injective-chain-releases/releases/download/v1.0.1-1630308393/linux-amd64.zip

unzip linux-amd64.zip

sudo mv injectived peggo injective-exchange /usr/bin
#check version
injectived version 
 
# Should output
#Version dev (b174465)
```

### Step 6
Continue syncing to the latest block.

```
injectived start
```

**NOTE:** If you want to continue sync as a background process, follow the official guide [using systemd service][using-systemd-guide-link].
**Make sure you update back ExecStart commannd** by removing `--halt-height 2045750` param.


`ExecStart=/bin/bash -c '/usr/bin/injectived --log-level=error start'`


Start systemd service

`sudo systemctl start injectived && sudo systemctl enable injectived`


Wait until the sync finishes, and the block height should reach the latest chain block. Follow via API

```
curl localhost:26657/status | grep height
```

When it reaches network block height, your node is fully synced, and you are running the latest version of the injective chain.


[sync-guide-link]: https://docs.injective.network/docs/staking/mainnet/validate-on-mainnet/sync-from-snapshot/
[using-systemd-guide-link]: https://chain.injective.network/guides/mainnet/join-network.html
