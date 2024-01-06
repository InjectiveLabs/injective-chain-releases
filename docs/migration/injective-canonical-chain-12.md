# Injective v1.12.0 Volan Upgrade 🥷

## Upgrade Guide

This is a software upgrade proposal for Injective. If passed, [Proposal 314](https://hub.injective.network/proposals/314/) would commit the Injective Chain to halt at block [57076000](https://www.mintscan.io/injective/blocks/57076000) (approximately 14:00 UTC on Thursday 11st 2023) and resume with the v1.12.0 version of the application binary.

Validators can find a step-by-step guide on the upgrade procedure in the long-form [proposal](https://docs.injective.network/nodes/Validators/mainnet/Canonical_Chain_Upgrade/canonical-1-12).

### Versions

| Binary    | Version |Commit Hash
| -------- | ------- |------- |
| injectived  | 1.12.0   |b92723b13e8f884053b5c5c0bc9b3fac59e1a3b5|
| peggo  | 1.12.0   |9e702f1ec4539746217c5352584d64d7038c7e83|

`Go version 1.19`

Verify you're using the correct version by running the below commands:
```bash
injectived version
peggo version
```

```bash
docker run public.ecr.aws/l9h3g6c6/injective-core:v1.12.0 injectived version
docker run public.ecr.aws/l9h3g6c6/peggo:v1.12.0 peggo version
```

### 🐳 Docker

Docker images have support for both `amd64` and `arm64` architectures.

| Image    | Description |
| -------- | ------- |
| public.ecr.aws/l9h3g6c6/injective-core:v1.12.0 | Debian image |
| public.ecr.aws/l9h3g6c6/peggo:v1.12.0 | Alpine image |

### 🕊️ Download Binaries

```bash
wget https://github.com/InjectiveLabs/injective-chain-releases/releases/download/v1.12.0-1704530206/linux-amd64.zip
unzip linux-amd64.zip
sudo mv injectived peggo /usr/bin
sudo mv libwasmvm.x86_64.so /usr/lib
```
