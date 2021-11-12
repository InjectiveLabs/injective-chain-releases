# Injective Canonical Chain Upgrade Instructions

The following document describes the necessary steps involved that validators and full node operators
must take in order to upgrade Canonical Chain from 10002-rc1 to 10002-rc2. The upgrade will take place via an on-chain software upgrade proposal passed by the Injective Chain governance.
If passed, this proposal would commit the Injective Mainnet to halting the Canonical Chain 10002-rc1 `injectived` application binary at approximately 14:00 UTC on Nov 15th and starting the application binary for the Injective Canonical Chain.

In case of a failed migration via the upgrade module, the Injective Labs team will post an official `injective-canonical-chain` genesis file, but it is recommended that validators should do try to export the genesis on their own node to verify the resulting genesis file.

Following [proposal `TO-BE-FILLED`](TO-BE-FILLED)
This indicates that the upgrade procedure should be performed on block number `4594100`.

  - [Summary](#summary)
  - [Risks](#risks)
  - [Recovery](#recovery)
  - [Upgrade Procedure](#upgrade-procedure)
  - [Notes for Service Providers](#notes-for-DEX-relayer-providers)

# Summary

The Injective Canonical Chain 10002-rc1 will undergo a scheduled upgrade to Injective Canonical Chain 10002-rc2 release on Monday, November 15th.

The following is a short summary of the upgrade steps:

1. Vote and wait till the node panics at block height 4,594,100.
2. Backing up configs, data, and keys used for running the Injective Canary Chain.
3. Install the [Injective Chain 10002-rc2 release](https://github.com/InjectiveLabs/injective-chain-releases/releases/tag/v1.1.1-1636733798)
4. Starting your node with the new injectived binary to fulfill the upgrade.

Upgrade coordination and support for validators will be available on the #mainnet-validators private channel of the [Injective Discord](https://discord.gg/injective).

The network upgrade can take the following potential pathways:
1. Happy path  
Validators successfully migrate from Canonical chain 10002-rc1 to 10002-rc2 without purging the blockchain history and all validators are up within 1-2 hours of the scheduled upgrade.

2. Not-so-happy path  
Validators have trouble upgrading the chain. This could be some consensus breaking changes not covered in upgrade handler, or compatibility issue of the migrated state with new injectived binary, but validators can at least export the genesis.

3. Abort path  
In the rare event that the team becomes aware of unnoticed critical issues, the Injective team will attempt to patch all the breaking states and provide another official binary within 36 hours.  
If the chain is not successfully resumed within 36 hours, the upgrade will be announced as aborted on the #mainnet-validators channel of [Discord](https://discord.gg/injective), and validators will need to resume running the Canary chain without any updates or changes. A new governance proposal for the upgrade will need to be issued and voted on by the community for the next upgrade.

## Risks

As a validator performing the upgrade procedure on your consensus nodes carries a heightened risk of
double-signing and being slashed. The most important piece of this procedure is verifying your
software version and genesis file hash before starting your validator and signing.

The riskiest thing a validator can do is discover that they made a mistake and repeat the upgrade
procedure again during the network startup. If you discover a mistake in the process, the best thing
to do is wait for the network to start before correcting it. If the network is halted and you have
started with a different genesis file than the expected one, seek advice from an Injective developer
before resetting your validator.

## Recovery

Prior to exporting the Canonical chain state, validators are encouraged to take a full data snapshot at the
export height before proceeding. Snapshotting depends heavily on infrastructure, but generally this
can be done by backing up the `.injectived` directory. We would suggest using aws s3 sync with delete flag, this will shorten the snapshotting time as only diff are uploaded to s3 bucket.

It is critically important to backup the `.injectived/data/priv_validator_state.json` file after stopping your injectived process. This file is updated every block as your validator participates in a consensus rounds. It is a critical file needed to prevent double-signing, in case the upgrade fails and the previous chain needs to be restarted.

In the event that the upgrade does not succeed, validators and operators must restore the snapshot and downgrade back to
[Injective Chain 10002-rc1 release](https://github.com/InjectiveLabs/injective-chain-releases/releases/tag/v1.1.0-1636178708) and continue the chain until next upgrade announcement.

## Upgrade Procedure

1. Verify you are currently running the correct version (`eb018590`) of `injectived`:
   ```bash
   $ injectived version
   Version v1.0.3 (eb018590)
   Compiled at 20211108-1431 using Go go1.17.3 (amd64)
   ```

2. After the chain has halted, make a backup of your `.injectived` directory
    ```bash
    cp ~/.injectived ./injectived-backup
    ```
    **NOTE**: It is recommended for validators and operators to take a full data snapshot at the export
    height before proceeding in case the upgrade does not go as planned or if not enough voting power
    comes online in a sufficient and agreed upon amount of time. In such a case, the chain will fallback
    to continue operating the Canary Chain. See [Recovery](#recovery) for details on how to proceed.

3. Download and install the injective-chain 10002-rc2 release
  ```bash
  wget `https://github.com/InjectiveLabs/injective-chain-releases/releases/download/v1.1.1-1636733798/linux-amd64.zip`
  unzip linux-amd64.zip
  sudo mv injectived /usr/bin
  ```

4. Verify you are currently running the correct version (`096cbe5`) of `injectived` after downloading the 10002-rc2 release:
    ```bash
   $ injectived version
   Version dev (096cbe5)
   Compiled at 20211112-1620 using Go go1.17.2 (amd64)
   ```

5. Coordinate to restart your injectived with other validators
   ```bash
   injectived start
   ```
   The binary will perform the upgrade automatically and continue the next consensus round if everything goes well.

## Notes for DEX relayer providers
Relayer upgrade will be available after the chain is successfully upgraded as it relies on several other components that work with injectived.
