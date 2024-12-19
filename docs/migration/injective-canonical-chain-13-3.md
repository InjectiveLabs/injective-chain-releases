# Injective v1.13.3 Upgrade 🥷

## Upgrade Guide
This is a non-consensus-breaking software upgrade that includes security fixes. Validators and node operators need to upgrade to v1.13.3 of the application binary as soon as possible.

**NOTE:** Validators only need to upgrade injectived, not peggo or libwasm versions.

### Versions

| Binary    | Version |Commit Hash
| -------- | ------- |------- |
| injectived  | v1.13.3   |d92e960879d7c256b4384eb8626257e5b6183022|
| peggo  | v1.13.0   |ead1119207cf23498e0f2b46343d060f01e7b353|

`Go version 1.22`

Verify you're using the correct version by running the below commands:
```bash
injectived version
peggo version
```

```bash
docker run public.ecr.aws/l9h3g6c6/injective-core:v1.13.3 injectived version
docker run public.ecr.aws/l9h3g6c6/peggo:v1.13.0 peggo version
```

### 🐳 Docker

Docker images have support for both `amd64` and `arm64` architectures.

| Image    | Description |
| -------- | ------- |
| public.ecr.aws/l9h3g6c6/injective-core:v1.13.3 | Debian image |
| public.ecr.aws/l9h3g6c6/peggo:v1.13.0 | Alpine image |

### 🕊️ Download Binaries

```bash
wget https://github.com/InjectiveLabs/injective-chain-releases/releases/download/release-prod-1734610315/linux-amd64.zip
unzip linux-amd64.zip
sudo mv injectived /usr/bin
```
