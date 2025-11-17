# Indexer Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

## [v1.17.19] - 2025-05-12

### Fixed
- [EventProvider] Reduce warning log verbosity when verifying large block sizes.

## [v1.17.17] - 2025-05-12

### Fixed
- [Exchange] Fix derivative market last funding not been updated under certain conditions.

## [v1.17.16] - 2025-05-11

### Added
- Compatibility with Injective Chain v1.17.X
- [Exchange] Index Derivative Market OpenInterest cap.
- [Exchange] Track total funding payments for open derivative positions.
- [Explorer] Index Ethereum transaction ID hash.
- [Explorer] Create database indexes asynchronously to improve startup time.

### Fixed
- [EventProvider] Ingesting upgrade blocks bigger than block max size.

### Deprecated
- [Chronos] Service is deprecated in favour of the new _Charts_ service and will be removed in future releases. See [Migration guide](https://www.notion.so/injective/Chronos-Migration-Guide-2a97a004ab758014b2ffe7348c94faa7)
- [Explorer] The following APIs have been deprecated and will be removed in future releases:
  - [HTTP] `/api/explorer/v1/accountTxs`: use `/api/explorer/v2/accountTxs`.
  - [HTTP] `/api/explorer/v1/blocks`: use `/api/explorer/v2/blocks`.
  - [HTTP] `/api/explorer/v1/contractTxs/{address}`: use `/api/explorer/v2/contractTxs/{address}`.
  - [HTTP] `/api/explorer/v1/txs`: use `/api/explorer/v2/txs`.
  - [RPC] `GetAccountTxs`: use `GetAccountTxsV2`.
  - [RPC] `GetBlocks`: use `GetBlocksV2`.
  - [RPC] `GetContractTxs`: use `GetContractTxsV2`.
  - [RPC] `GetTxs`: use `GetTxsV2`.




