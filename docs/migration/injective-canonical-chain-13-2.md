# Injective v1.13.2 Upgrade 🥷

## Upgrade Guide


This is a software upgrade proposal for Injective. If passed, [Proposal 424](https://hub.injective.network/proposal/424/) would commit the Injective Chain to halt at block [82830000](https://www.mintscan.io/injective/blocks/82830000) (approximately 15:00 UTC on Thursday August 20th 2024) and resume with the v1.13.2 version of the application binary.

Validators can find a step-by-step guide on the upgrade procedure in the long-form [proposal](https://docs.injective.network/nodes/validators/mainnet/canonical_chain_upgrade/canonical-1.13.2).

Validators should also upgrade the peggo version.

### Versions

| Binary    | Version |Commit Hash
| -------- | ------- |------- |
| injectived  | v1.13.2   |6f57bf030ab772b5374a0647efa9e4565582ad42|
| peggo  | v1.13.0   |ead1119207cf23498e0f2b46343d060f01e7b353|

`Go version 1.22`

Verify you're using the correct version by running the below commands:
```bash
injectived version
peggo version
```

```bash
docker run public.ecr.aws/l9h3g6c6/injective-core:v1.13.2 injectived version
docker run public.ecr.aws/l9h3g6c6/peggo:v1.13.0 peggo version
```

### 🐳 Docker

Docker images have support for both `amd64` and `arm64` architectures.

| Image    | Description |
| -------- | ------- |
| public.ecr.aws/l9h3g6c6/injective-core:v1.13.2 | Debian image |
| public.ecr.aws/l9h3g6c6/peggo:v1.13.0 | Alpine image |

### 🕊️ Download Binaries

```bash
wget https://github.com/InjectiveLabs/injective-chain-releases/releases/download/v1.13.2-1723753267/linux-amd64.zip
unzip linux-amd64.zip
sudo mv injectived peggo /usr/bin
sudo mv libwasmvm.x86_64.so /usr/lib
```
