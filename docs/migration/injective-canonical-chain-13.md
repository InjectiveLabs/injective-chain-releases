# Injective v1.13.0 Altaris Upgrade 🥷

## Upgrade Guide

This is a software upgrade proposal for Injective. If passed, [Proposal 420](https://hub.injective.network/proposals/420/) would commit the Injective Chain to halt at block [80319200](https://www.mintscan.io/injective/blocks/80319200) (approximately 15:00 UTC on Thursday Aug 1st 2024) and resume with the v1.13.0 version of the application binary.

Validators can find a step-by-step guide on the upgrade procedure in the long-form [proposal](https://docs.injective.network/nodes/Validators/mainnet/Canonical_Chain_Upgrade/canonical-1-13).

### Versions

| Binary    | Version |Commit Hash
| -------- | ------- |------- |
| injectived  | 1.13.0   |XXXXX|
| peggo  | 1.13.0   |XXXXX|

`Go version 1.XX`

Verify you're using the correct version by running the below commands:
```bash
injectived version
peggo version
```

```bash
```

### 🐳 Docker

Docker images have support for both `amd64` and `arm64` architectures.

| Image    | Description |
| -------- | ------- |
|  | Debian image |
|  | Alpine image |

### 🕊️ Download Binaries

```bash
wget https://github.com/InjectiveLabs/injective-chain-releases/releases/download/v1.13.0-XXXXXXXX/linux-amd64.zip
unzip linux-amd64.zip
sudo mv injectived peggo /usr/bin
sudo mv libwasmvm.x86_64.so /usr/lib
```
