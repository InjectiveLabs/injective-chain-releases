# Injective Network

These instructions will guide you in running a dockerized version of the Injective Chain Components on [mainnet](#configure-environment) or [testnet](#configure-environment).

* Injective Chain Node
* Relayer
* Trading API components (Market makers)


# Prerequisites

**Hardware Requirments**

| Minimum          | Recommendation |
| -----------------| ---------------|
| Memory: 16Gb     | Memory: 32Gb+  |
| Storage: 1Tb     | Storage: 2Tb   |
| Network: 5Gbps+  | Network: 5Gbps+|


**Software Requirments**

* [Docker Version 20.X.X](get-docker-link)
* [docker compose version 2.11.X](get-compose-link)
* [Git](get-git-link)

# Getting Started

NOTE: All commands are executed from the current path level, the `docker` directory.


## Configure Environment

 Network-related environment variables are defined in the `.env.$NETWORK.example` files for each of the networks.

```bash
# Where $NETWORK is either `mainnet` or `testnet`
cp .env.$NETWORK.example .env
```

Edit `.env` file.

The most important/required environment variables are

| NAME         | OPTIONS                 | DEFAULT |
| -------------| ----------------------|---------|
| NETWORK      | mainnet, tesnet       | mainnet |
| APP_ENV      | prod/staging          | prod    |
| APP_VERSION  | vx.x.x          | v1.7.1    |
| INJ_IMAGE_TAG| x.x.x            | 1.7.1    |
| LOG_LEVEL    | error/warn/info/debug | info    |
| CHAIN_ID     | injective-1, injective-888 | injective-1 |
|


*IMPORTANT:* Setup correct `NETWORK` env, options are `mainnet` or `testnet`.

# Running the Setup

## First Time Setup

Running an Injective stack for the first time requires provisioning, configuration, and data sync.
This is a seamless and fully automated process handled by the injective provisioning container.


```bash
docker compose -f docker-compose.yaml -f addons/docker-compose.provisioner.yaml up -d provisioner
```

The provisioning process is now running in the background. You can follow its progress by using the command:

```bash
docker logs -f injective-provisioner 
```

On a good connection, it takes approximately one-two hours to fully sync. This process may take longer for machines with slower internet connections.

After successfully completing the syncing process you should see the message:

`### Successful Provisioning ###`

This means that you can now run the Injective Relayer or Trading stack.


## Running the Injective Components

### Injective Relayer Stack ###

This stack contains the Relayer components. It will run:

* Injective Core (injectived)
* Injective Trading API components (exchange API, exchange Gateway, exchange process)

```bash
docker compose -f docker-compose.yaml -f docker-compose.prod.yaml up -d --remove-orphans mongo injective-core indexer-exchange-process indexer-exchange-api indexer-chronos-process indexer-chronos-api
```

### Injective Trading Stack ####

This stack contains additional trading components. It will run:

* Injective Core (injectived)
* Injective Trading API components (exchange API, exchange Gateway, exchange process, trading bot, liquidator bot, price oracle)

```bash
docker compose -f docker-compose.yaml -f docker-compose.prod.yaml up -d --remove-orphans
```

## Check logs

```
docker compose -f logs
```

## Restart the Network

```
docker compose -f docker-compose.yaml -f docker-compose.prod.yaml restart
```

## Stop the Network

```
docker compose -f docker-compose.yaml -f docker-compose.prod.yaml stop
```

## Down all the containers and delete the network

```
docker compose -f docker-compose.yaml -f docker-compose.prod.yaml down
```

# Using the Makefile
Replace `$NETWORK` with either `mainnet` or `testnet` when running these commands
## Edit the environment variables
The makefile references the `.env.$NETWORK.example` files. Edit these files before proceeding to the next step.
## Initial setup
Run the command below to provision, configure and sync your setup.

```bash
make provision-$NETWORK
```

## Initialize the Injective Core and the Mongo Database
Initialize `injective-core` and the `Mongo` database
```bash
make init-$NETWORK
```

## Initialize the Relayer Components
```bash
make relayer-$NETWORK
```

## Follow Component Logs
To follow the logs of a running service/component, use the command:
```bash
# Where component = core, mongo, chronos-api, chronos-process, exchange-api, exchange-process
make follow-$COMPONENT

# Example for viewing logs for the exchange-api
make follow-exchange-api
```

## Destroy the Setup
```bash
make destroy-$NETWORK
```
# Get Involved

Injective Protocol is a community-driven project; we welcome all contributions.

* Discuss with [Discord community][discord-community-link]
* Join Injective on [Telegram][telegram-community-link]
* [Github repositories][injective-github-repo]
* Follows us on [Twitter][injective-twitter-link]


[discord-community-link]: https://discord.com/invite/injective
[telegram-community-link]: https://t.me/joininjective
[injective-docs]: https://chain.injective.network/
[injective-twitter-link]: https://twitter.com/InjectiveLabs
[injective-github-repo]: https://github.com/InjectiveLabs
[get-docker-link]:https://docs.docker.com/get-docker/
[get-compose-link]: https://docs.docker.com/compose/install/
[get-git-link]: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
