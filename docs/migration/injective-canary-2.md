# Injective Canary 1 Upgrade Instructions

The following document describes the necessary steps involved that validators and full node operators
must take in order to upgrade from `injective-canary-1` to `injective-canary-2`. The Injecive team
will post an official `injective-canary-2` genesis file, but it is recommended that validators
execute the following instructions in order to verify the resulting genesis file.

There is a strong social consensus around proposal `Injective Canary 2 Upgrade Proposal`
on `injective-canary-1`. Following proposal #[27](https://hub.injective.network/proposals/TO-BE-DETERMINED)
This indicates that the upgrade procedure should be performed on `TO-BE-DETERMINED`
  - [Summary](#summary)
  - [Migrations](#migrations)
  - [Preliminary](#preliminary)
  - [Major Updates](#major-updates)
  - [Risks](#risks)
  - [Recovery](#recovery)
  - [Upgrade Procedure](#upgrade-procedure)
  - [Notes for Service Providers](#notes-for-DEX-relayer-providers)

# Summary

The injective-canary-1 will undergo a scheduled upgrade to injective-canary-2 on `TO-BE-DETERMINED`.

The following is a short summary of the upgrade steps:
    1. Vote and wait till your node panic at chosen upgrade height
    1. Backing up configs, data, and keys used for running injective-canary-1
    1. Installing the injective-chain 10002-rc1 release
    1. Starting the node with new injectived binary to fulfill the upgrade

Specific instructions for validators are available in [Upgrade Procedure](#upgrade-procedure),
and specific instructions for full node operators are available in [Guidance for Full Node Operators](#guidance-for-full-node-operators).

Upgrade coordination and support for validators will be available on the #validators-verified channel of the [Injective Discord](TO-BE-DETERMINED).

The network upgrade can take the following potential pathways:
1. Happy path  
Validator successfully migrates from injective-canary-1 to injective-canary-2 chain without purging the blockchain history and all validators are up within 1-2 hours of the scheduled upgrade.

1. Not-so-happy path  
Validators have trouble migrating from injective-canary-1 to injective-canary-2 chain. This could be some consensus breaking changes not covered in upgrade handler, or compatibility issue of the migrated state with new injectived binary, but validators can at least export the genesis.

1. Abort path  
In the rare event that the team becomes aware of unnoticed critical issues, Injective team will attempt to patch all the breaking states upgrade and provide another working binary within 36 hours.  
If the chain is not successfully resumed within 36 hours, the upgrade will be announced as aborted on the #mainnet-validators channel of [Discord](TO-BE-DETERMINED), and validators will need to resume running injective-canary-1 network without any updates or changes. A new governance proposal for the upgrade will need to be issued and voted on by the community.

# Migrations

These chapters contain all the migration guides to update your app and modules to Injective Canary 2.

If you’re running a block explorer, wallet, exchange, validator, relayer, trading API server or any other service (eg. custody provider) that depends upon the Injective Chain, you’ll want to pay attention, because this upgrade will involve substantial changes.

## Preliminary

Many changes have occurred to the Injective go-sdk and the Injectived application since the latest
major upgrade (`injective-canary-1`). These changes notably consist of many new features,
protocol changes, and application structural changes that favor developer ergonomics
and application development.

1. TO-BE-DETERMINED
2. TO-BE-DETERMINED
3. TO-BE-DETERMINED

Validators should expect that at least 16GB of RAM needs to be provisioned to process the first new block on injective-canary-2.

## Major Updates

inform about major & breaking changes, link to articles, docs. TO-BE-DETERMINED

Some of the biggest changes to take note on when upgrading as a developer or client are the the following:

- **Protocol Buffers**: Initially the Cosmos SDK used Amino codecs for nearly all encoding and decoding.
In this version a major upgrade to Protocol Buffers have been integrated. It is expected that with Protocol Buffers
applications gain in speed, readability, convinience and interoperability with many programming languages.
[Read more](https://github.com/cosmos/cosmos-sdk/blob/master/docs/migrations/app_and_modules.md#protocol-buffers)
- **CLI**: The CLI and the daemon for a blockchain were seperated in previous versions of the Cosmos SDK. This
led to a `gaiad` and `gaiacli` binary which were seperated and could be used for different interactions with the
blockchain. Both of these have been merged into one `gaiad` which now supports the commands the `gaiacli` previously
supported.
- **Node Configuration**: Previously blockchain data and node configuration was stored in `~/.gaia/`, these will
now reside in `~/.gaia/`, if you use scripts that make use of the configuration or blockchain data, make sure to update the path.

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

Prior to exporting `injective-canary-1` state, validators are encouraged to take a full data snapshot at the
export height before proceeding. Snapshotting depends heavily on infrastructure, but generally this
can be done by backing up the `.injectived` directory.

It is critically important to back-up the `.injectived/data/priv_validator_state.json` file after stopping your injectived process. This file is updated every block as your validator participates in a consensus rounds. It is a critical file needed to prevent double-signing, in case the upgrade fails and the previous chain needs to be restarted.

In the event that the upgrade does not succeed, validators and operators must restore the snapshot and downgrade back to
injective-chain 10001-rc7 release and continue the chain until next upgrade announcement.

## Upgrade Procedure

The version/commit hash of Injectived 10002-rc1 release `TO-BE-DETERMINED`: `TO-BE-DETERMINED`

1. Verify you are currently running the correct version (TO-BE-DETERMINED) of _injectived_:
   ```bash
   $ injectived version
   version: `TO-BE-DETERMINED`
   commit: `TO-BE-DETERMINED`
   go: `TO-BE-DETERMINED`
   ```

1. After the chain has halted, make a backup of your `.injectived` directory
    ```bash
    mv ~/.injectived ./injectived-backup
    ```

    **NOTE**: It is recommended for validators and operators to take a full data snapshot at the export
   height before proceeding in case the upgrade does not go as planned or if not enough voting power
   comes online in a sufficient and agreed upon amount of time. In such a case, the chain will fallback
   to continue operating `injective-canary-1`. See [Recovery](#recovery) for details on how to proceed.

1. Download injective-chain 10002-rc2 release
  ```bash
  wget TO-BE-DETERMINED
  ```

1. Verify you are currently running the correct version (TO-BE-DETERMINED) of the _injectived_ after downloading 10002-rc1 release:
   ```bash
   $ injectived version
   version: `TO-BE-DETERMINED`
   commit: `TO-BE-DETERMINED`
   go: `TO-BE-DETERMINED`
   ```

1. Coordinate to restart your injectived with other validators
   ```bash
   injectived start
   ```
   The binary will perform automatic upgrade and continue next consensus round if everything goes well.

## Notes for DEX relayer providers
Relayer upgrade will be available after the chain is successfully upgraded as it relies on several other components than work with the injectived.
