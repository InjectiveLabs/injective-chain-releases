# Injective v1.13.0 Upgrade 🥷

## Upgrade Guide


This is a software upgrade proposal for Injective. If passed, [Proposal 420](https://hub.injective.network/proposals/420/) would commit the Injective Chain to halt at block [80319200](https://www.mintscan.io/injective/blocks/80319200) (approximately 14:00 UTC on Thursday August 1st 2024) and resume with the v1.13.0 version of the application binary.

Validators can find a step-by-step guide on the upgrade procedure in the long-form [proposal](https://docs.injective.network/nodes/validators/mainnet/canonical-chain-upgrade/canonical-1.13.0).

Validators should also upgrade the peggo version.

### Versions

| Binary    | Version |Commit Hash
| -------- | ------- |------- |
| injectived  | v1.13.0   |af924ca9e5c498a1848276d7b4d47e271a676f0e|
| peggo  | v1.13.0   |ead1119207cf23498e0f2b46343d060f01e7b353|

`Go version 1.22`

Verify you're using the correct version by running the below commands:
```bash
injectived version
peggo version
```

```bash
docker run public.ecr.aws/l9h3g6c6/injective-core:v1.13.0 injectived version
docker run public.ecr.aws/l9h3g6c6/peggo:v1.13.0 peggo version
```

### 🐳 Docker

Docker images have support for both `amd64` and `arm64` architectures.

| Image    | Description |
| -------- | ------- |
| public.ecr.aws/l9h3g6c6/injective-core:v1.13.0 | Debian image |
| public.ecr.aws/l9h3g6c6/peggo:v1.13.0 | Alpine image |

### 🕊️ Download Binaries

```bash
wget https://github.com/InjectiveLabs/injective-chain-releases/releases/download/v1.13.0-1722157491/linux-amd64.zip
unzip linux-amd64.zip
sudo mv injectived peggo /usr/bin
sudo mv libwasmvm.x86_64.so /usr/lib
```
