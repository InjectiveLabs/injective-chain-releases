# Scripts
Those are set of scripts that will help you to bootstrap the Injective node or sync it with the network. 

**NOTE:**  If you are running scripts on an existing node, your configuration will be backed up before the sync process. Nevertheless, We highly recommend that you also do a manual backup of node configuration, keyring [following this step][backup-link].

##  Requirments
* [Go Installed][go-install-link]
* [Git Installed][git-link]
* [AWS CLI][aws-cli-install-link] (only for snapshot sync, aws account not required)

## Getting Started

### For node create 
Run [node-create script](node-sync.sh).

```
git clone https://github.com/InjectiveLabs/injective-chain-releases.git
cd scripts
./node-create.sh
```
### For node sync from snapshot

Run [node-sync script](node-sync.sh).

```
git clone https://github.com/InjectiveLabs/injective-chain-releases.git
cd scripts
./node-sync.sh
```

Wait until the sync process completes. It can take few hours, depending on your internet connection. If the process is interrupted and the script stops (server restart or any other reason), run it again. It will continue the sync process.


[backup-link]: https://docs.injective.network/docs/staking/mainnet/validate-on-mainnet/sync-from-snapshot/#step-1-backup-node-credentials-keyring--clear-local-injectived-data
[git-link]:https://github.com/git-guides/install-git
[go-install-link]: https://golang.org/doc/install
[aws-cli-install-link]: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html