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
| NETWORK      | mainnet, testnet       | mainnet |
| APP_ENV      | prod/staging          | prod    |
| APP_VERSION  | vx.x.x          | v1.7.1    |
| INJ_IMAGE_TAG| x.x.x            | 1.7.1    |
| LOG_LEVEL    | error/warn/info/debug | info    |
| CHAIN_ID     | injective-1, injective-888 | injective-1 |
| INDEXER_COSMOS_TLS_ENABLED | "false","true"| "false"|


*IMPORTANT:* Setup correct `NETWORK` env, options are `mainnet` or `testnet`.

# Running the Setup

## First Time Setup

Running an Injective stack for the first time requires provisioning, configuration, and data syncing.
This is a seamless and fully automated process handled by the injective provisioning container.


```bash
docker compose -f docker-compose.yaml -f addons/docker-compose.provisioner.yaml up -d provisioner
```

The provisioning process is now running in the background. You can follow its progress by using the command:

```bash
docker logs -f injective-provisioner 
```

On a good connection, it would take approximately one to two hours to fully sync. This process may take longer for machines with slower internet connections.

After successfully completing the syncing process you should see the message:

`### Successful Provisioning ###`

This means that you can now run the Injective Relayer or Trading stack.


## Running the Injective Components
### Injective Core and MongoDB ###
```bash
docker compose -f docker-compose.yaml -f docker-compose.prod.yaml up -d --remove-orphans mongo injective-core
```
To check if the chain has fully synced by running this command:
```bash
curl localhost:26657/status | grep -E "height|catching" 
```
Once the chain sync finished you should see `"catching_up": false` in the response

To check the progress of the event provider and exchange database sync run
```bash
mongosh exchangeV2 --eval "db.system.find().pretty()"
mongosh eventProviderV2 --eval "db.system.find().pretty()"
```
### Injective Market Maker Stack ###

This stack contains the Market Maker components. It will run:
* Injective Market Maker API components (exchange API, exchange process, event provider API, event provider process)

You can either run your own event provider service or point to our events endpoint. 

To use our events endpoint set these environment variables on your `.env` file
```bash
INDEXER_DB_EVENTPROVIDER_ENDPOINT=https://k8s.mainnet.events.grpc-web.injective.network
INDEXER_DB_EVENTPROVIDER_GRPC_ADDRESS=https://k8s.mainnet.events.grpc.injective.network
```
To run your own event provider service, run the commands below:
```bash
docker compose -f docker-compose.yaml -f docker-compose.prod.yaml -f addons/docker-compose.dex.yaml up -d --remove-orphans indexer-eventprovider-process indexer-eventprovider-api
```
Wait until the event provider has finished syncing. You can check its progress and see if it has completed syncing by running:
```bash
sudo docker logs indexer-eventprovider-process | grep "initial sync completed"
```
Once you've setup or pointed to an event provider, you can run the rest of the Market Maker stack
```bash
docker compose -f docker-compose.yaml -f docker-compose.prod.yaml -f addons/docker-compose.dex.yaml up -d --remove-orphans indexer-exchange-process indexer-exchange-api
```
Wait until the exchange has finished syncing. You can check its progress and see if it has completed syncing by running the command below.
```bash
docker logs indexer-exchange-process | grep "initial sync completed"
```
### Injective DEX Stack ####
This stack contains the DEX components. It will run:
* Injective DEX API components (exchange API, exchange process, event provider API, event provider process, chronos API, chronos process, explorer API, explorer process)

To run the additional components needed for the DEX stack you should run this command after completing the Market Maker stack guide.

```bash
docker compose -f docker-compose.yaml -f docker-compose.prod.yaml -f addons/docker-compose.dex.yaml up -d --remove-orphans
```
Wait until the explorer and chronos has finished syncing. You can check its progress and see if it has completed syncing by running the command below.
```bash
docker logs indexer-explorer-process | grep "initial sync completed"
docker logs indexer-chronos-process | grep "initial sync completed"
```
## Check logs

```
docker compose -f logs
```

## Restart the Network

```
docker compose -f docker-compose.yaml -f docker-compose.prod.yaml -f addons/docker-compose.dex.yaml restart
```

## Stop the Network

```
docker compose -f docker-compose.yaml -f docker-compose.prod.yaml -f addons/docker-compose.dex.yaml stop
```

## Down all the containers and delete the network

```
docker compose -f docker-compose.yaml -f docker-compose.prod.yaml -f addons/docker-compose.dex.yaml down
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
## Initialize the Event Provider
```bash
make event-provider-$NETWORK
```
## Initialize the rest of the Relayer Components
```bash
make relayer-$NETWORK
```

## Follow Component Logs
To follow the logs of a running service/component, use the command:
```bash
# Where component = core, mongo, chronos-api, chronos-process, exchange-api, exchange-process, eventprovider-process, eventprovider-api
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
