# Injective Network

Following those instructions, you will run dockerized [Injective Chain Components on mainnet](#running-mainnet).

* Injective Chain Node
* Relayer
* Trading API components (Market makers)


# Prerequests

**Hardware Requirments**

| Minimum          | Recommendation |
| -----------------| ---------------|
| Memory: 16Gb     | Memory: 32Gb+  |
| Storage: 1Tb     | Storage: 2Tb   |
| Network: 5Gbps+  | Network: 5Gbps+|


**Software Requirments**

* [Docker Version 20.X.X][get-docker-link]
* [docker-compose version 1.29.X][get-compose-link]
* [Git][get-git-link]

# Getting Started

NOTE: All commands are executed from the current path level, a `docker` folder.


## Configure Environment

 Network-related env variables are defined in `.env` file. There is a `.env.example` that you can copy and use as a starting point.

`cp .env.example .env`

Edit `.env` file.

The most important/required environment variables are

| NAME         | OPTIONS                 | DEFAULT |
| -------------| ----------------------|---------|
| NETWORK      | mainnet, tesnet       | mainnet |
| APP_ENV      | prod/staging          | prod    |
| APP_VERSION  | prod/staging          | prod    |
| INJ_IMAGE_TAG| prod/local            | prod    |
| LOG_LEVEL    | error/warn/info/debug | info    |
| CHAIN_ID     | injective-1, injective-888 | injective-1 |
|


*IMPORTANT:* Setup correct `NETWORK` env, options are `mainnet` or `testnet`.

# Running mainnet

## First Time Setup

Running an Injective stack for the first time requires provisioning, configuration, and data sync.
This process is seamless and fully automated, thanks to the injective provisioning container.


```
 docker-compose -f docker-compose.yaml -f addons/docker-compose.provisioner.yaml up -d provisioner
```

From now on, the provisioning process in running in the background, you can follow with

`docker logs -f injective-provisioner`

It takes approximately one-two hours for full sync (depending on the internet connection also). After successful sync, the container will exit, and you will see the message.

`### Successful Provisioning ###`

From now on, you are ready to run Injective components.


## Running Components

### Injective Relayer Stack ###

This stack contains Relayer components. It will run

* Injective Core (injectived)
* Injective Trading API components (exchange API, exchange Gateway, exchange process)

```
docker-compose -f docker-compose.yaml -f docker-compose.prod.yaml up -d --remove-orphans mongo injective-core injective-exchange-process injective-exchange-api injective-exchange-gateway
```

### Injective Trading Stack ####

This stack contains additional trading components. It will run:

* Injective Core (injectived)
* Injective Trading API components (exchange API, exchange Gateway, exchange process, trading bot, liquidator bot, price oracle)

```
docker-compose -f docker-compose.yaml -f docker-compose.prod.yaml up -d --remove-orphans
```

## Check logs

```
docker-compose -f logs
```

## Restart the Network

```
docker-compose -f docker-compose.yaml -f docker-compose.prod.yaml restart
```

## Stop the Network

```
docker-compose -f docker-compose.yaml -f docker-compose.prod.yaml stop
```

## Remove all components and data

**NOTE** All data will be erased, and you will lose the whole setup, which will require running everything from scratch for the first time.
Use this command **ONLY** when you want to nuke the whole setup.

```
docker-compose -f docker-compose.yaml -f docker-compose.prod.yaml down
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
