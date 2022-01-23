# Injective Chain releases

The repository hosts Injective Chain releases of binary artifacts.

It also contains hassle-free guides and scripts for getting started and managing Injective Chain nodes.

### Guides included

* [Create a new node and join the network](guides/new-node.md)
* [Sync node from the snapshot](guides/sync-node.md) (quickest way to sync blocks).
* [Sync node from scratch via public sentries](guides/sync-node.md) (better decentralization factor).
* [Upgrade Node to the latest version](guides/upgrade-node.md)

## Requirements

The following requirements are required to run the node natively.

### Hardware

The following table shows the recommended hardware requirements for the running node on the mainnet.

| Validator Node | Sentry Node |
| -----------------| ---------------|
| Memory: 16Gb     | Memory: 16Gb+  |
| Storage: 1Tb     | Storage: 1Tb   |
| Network: 5Gbps+  | Network: 5Gbps+|

### Software

* [Go Installed][go-install-link]
* [Git Installed][git-link]
* [AWS CLI][aws-cli-install-link] (only for snapshot sync, aws account not required)

## Sentry Seed Nodes

For the **testnet**, find a list of seed nodes in seed.txt in the matching release folder [here][injective-netconf-test]

*Example, for testnet release [0.4.14](https://github.com/InjectiveLabs/injective-chain-releases/releases/tag/v0.4.14-1632990203)
you will find the seed node list in `40014/seed.txt`*

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
[injective-rest-api-testnet-link]: https://testnet.lcd.injective.dev/swagger/#/
[injective-rest-api-mainnet-link]: https://lcd.injective.network/swagger/#/
[injective-github-repo]: https://github.com/InjectiveLabs
[injective-docs]: https://chain.injective.network/
[injective-twitter-link]: https://twitter.com/InjectiveLabs
[injective-netconf-test]: https://github.com/InjectiveLabs/testnet-config/tree/master/staking
[injective-netconf-main]:https://github.com/InjectiveLabs/mainnet-config
