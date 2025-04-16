# Injective v1.14.1 Upgrade 🥷

## Upgrade Guide

This is a software upgrade proposal for Injective. If passed, [Proposal 500](https://hub.injective.network/proposal/500/) would commit the Injective Chain to halt at block [108175000](https://www.mintscan.io/injective/blocks/108175000) (approximately 14:00 UTC on Tuesday March 4, 2025) and resume with the v1.14.1 version of the application binary.

Validators can find a step-by-step guide on the upgrade procedure in the long-form [proposal](https://docs.injective.network/nodes/validators/mainnet/canonical-chain-upgrades/canonical-1.14.1).


### Versions

| Binary    | Version |Commit Hash
| -------- | ------- |------- |
| injectived  | v1.14.1   |0fe59376d|
| peggo  | v1.14.1   |5317d5c|

`Go version 1.22`

Verify you're using the correct version by running the below commands:
```bash
injectived version
peggo version
```

```bash
docker run public.ecr.aws/l9h3g6c6/injective-core:v1.14.1 injectived version
docker run public.ecr.aws/l9h3g6c6/peggo:v1.14.1 peggo version
```

### 🐳 Docker

Docker images have support for both `amd64` and `arm64` architectures.

| Image    | Description |
| -------- | ------- |
| public.ecr.aws/l9h3g6c6/injective-core:v1.14.1 | Debian image |
| public.ecr.aws/l9h3g6c6/peggo:v1.14.1 | Alpine image |

### 🕊️ Download Binaries

```bash
wget https://github.com/InjectiveLabs/injective-chain-releases/releases/download/v1.14.1-1740773301/linux-amd64.zip
unzip linux-amd64.zip
sudo mv injectived peggo /usr/bin
sudo mv libwasmvm.x86_64.so /usr/lib
```
