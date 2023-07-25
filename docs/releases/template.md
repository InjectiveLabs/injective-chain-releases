# Injective v0.0.0 Upgrade 🥷

## Usage

### Versions

| Binary    | Version |Commit Hash
| -------- | ------- |------- |
| injectived  | 0.0.0   |XXXXXX|
| peggo  | 0.0.0   |XXXXXX|

`Go version 1.19`

Verify you're using the correct version by running the below commands:
```bash
injectived version
peggo version
```

```bash
docker run public.ecr.aws/l9h3g6c6/injective-core:v0.0.0 injectived version
docker run public.ecr.aws/l9h3g6c6/peggo:v0.0.0 peggo version
```

### 🐳 Docker

Docker images have support for both `amd64` and `arm64` architectures.

| Image    | Description |
| -------- | ------- |
| public.ecr.aws/l9h3g6c6/injective-core:v0.0.0 | Alpine image |
| public.ecr.aws/l9h3g6c6/peggo:v0.0.0 | Alpine image |

### 🕊️ Download Binaries

```bash
wget https://github.com/InjectiveLabs/injective-chain-releases/releases/download/PLACEHOLDER/linux-amd64.zip
unzip linux-amd64.zip
sudo mv injectived peggo /usr/bin
sudo mv libwasmvm.x86_64.so /usr/lib
```
