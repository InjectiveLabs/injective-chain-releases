# Injective Chain releases

This repository hosts Injective Chain releases of binary artifacts.

It also contains hassle-free guides and scripts for getting started and managing Injective Chain nodes.

### Guides included

* [Injective Exchange Service Setup Guide](https://www.notion.so/Injective-Exchange-Service-Setup-Guide-7e59980634d54991862300670583d46a) (Includes Running a Node)
* [Create a new node and join the network](guides/new-node.md)
* [Sync node from a snapshot](guides/sync-node.md) (quickest way to sync blocks).
* [Upgrade Node to the latest version](guides/upgrade-node.md)

<!-- * [Sync node from scratch via public sentries](guides/sync-node.md) (better decentralization factor). -->


## Requirements

The following requirements are required to run the node natively.

### Hardware

The following table shows the minimum recommended hardware requirements for the running node on the mainnet.

| Validator Node   | Sentry Node    |
| -----------------| ---------------|
| CPU: 8 Cores     | CPU: 8 Cores   |
| Memory: 64Gb     | Memory: 64Gb+  |
| Storage: 2Tb     | Storage: 2Tb   |
| Network: 5Gbps+  | Network: 5Gbps+|

### Software

* [Go Installed][go-install-link]
* [Git Installed][git-link]
* [AWS CLI][aws-cli-install-link] (only for snapshot sync, aws account not required)

## Sentry Seed Nodes

For the **testnet**, find a list of seed nodes in seed.txt in the matching release folder [here][injective-netconf-test]

*Example, for testnet release [0.4.19](https://github.com/InjectiveLabs/injective-chain-releases/releases/tag/v0.4.19-1656563866)
you will find the seed node list in `70001/seeds.txt`*

For the **mainnet**, find a list of seed nodes matching your release [here][injective-netconf-main]

## Helpful links

* [Official Documentation][injective-docs]
* [Injective REST API Spec (Mainnet)][injective-rest-api-mainnet-link]
* [Injective REST API Spec (Testnet)][injective-rest-api-testnet-link]

# Get Involved

Injective Protocol is a community driven project; we welcome all contribution.

* Discuss with [Discord community][discord-community-link]
* Join Injective on [Telegram][telegram-community-link]
* [Github repositories][injective-github-repo]
* Follows us on [Twitter][injective-twitter-link]

[sync-node-link]:
[create-node-link]:
[upgrade-node-link]: https://docs.injective.network/docs/staking/mainnet/validate-on-mainnet/upgrading-your-node
[go-install-link]: https://golang.org/doc/install
[git-link]:https://github.com/git-guides/install-git
[aws-cli-install-link]: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html
[discord-community-link]: https://discord.com/invite/injective
[telegram-community-link]: https://t.me/joininjective
[injective-rest-api-testnet-link]: https://k8s.testnet.lcd.injective.network/swagger/#/
[injective-rest-api-mainnet-link]: https://lcd.injective.network/swagger/#/
[injective-github-repo]: https://github.com/InjectiveLabs
[injective-docs]: https://docs.injective.network/
[injective-twitter-link]: https://twitter.com/InjectiveLabs
[injective-netconf-test]: https://github.com/InjectiveLabs/testnet-config/tree/master/corfu
[injective-netconf-main]:https://github.com/InjectiveLabs/mainnet-config
