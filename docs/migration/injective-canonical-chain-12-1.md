# Injective v1.12.1 Upgrade 🥷

## Upgrade Guide

This is a non-consensus breaking release, node operators can upgrade in their earliest convenience.

All nodes, validator and non-consensus nodes must be upgraded as soon as possible to this version.

Validators should also upgrade the peggo version.

### Versions

| Binary    | Version |Commit Hash
| -------- | ------- |------- |
| injectived  | v1.12.1   |c1a64b7edeb18ad2af751c35f53d989c6f92483c|
| peggo  | v1.12.2   |e8089a7c54817dc9137907af2da45a6a9ef25a71|

`Go version 1.19`

Verify you're using the correct version by running the below commands:
```bash
injectived version
peggo version
```

```bash
docker run public.ecr.aws/l9h3g6c6/injective-core:v1.12.1 injectived version
docker run public.ecr.aws/l9h3g6c6/peggo:v1.12.2 peggo version
```

### 🐳 Docker

Docker images have support for both `amd64` and `arm64` architectures.

| Image    | Description |
| -------- | ------- |
| public.ecr.aws/l9h3g6c6/injective-core:v1.12.1 | Debian image |
| public.ecr.aws/l9h3g6c6/peggo:v1.12.2 | Alpine image |

### 🕊️ Download Binaries

```bash
wget https://github.com/InjectiveLabs/injective-chain-releases/releases/download/v1.12.1-1705909076/linux-amd64.zip
unzip linux-amd64.zip
sudo mv injectived peggo /usr/bin
sudo mv libwasmvm.x86_64.so /usr/lib
```
