#!/bin/bash

set -e

killall injectived &>/dev/null || true
rm -rf ~/.injectived

CHAINID="injective-1"
MONIKER="injective"
PASSPHRASE="12345678"
FEEDADMIN="inj1k2z3chspuk9wsufle69svmtmnlc07rvw9djya7"

# Set moniker and chain-id for Ethermint (Moniker can be anything, chain-id must be an integer)
injectived init $MONIKER --chain-id $CHAINID
perl -i -pe 's/^timeout_commit = ".*?"/timeout_commit = "2500ms"/' ~/.injectived/config/config.toml
perl -i -pe 's/^minimum-gas-prices = ".*?"/minimum-gas-prices = "500000000inj"/' ~/.injectived/config/app.toml

cat $HOME/.injectived/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="inj"' > $HOME/.injectived/config/tmp_genesis.json && mv $HOME/.injectived/config/tmp_genesis.json $HOME/.injectived/config/genesis.json
cat $HOME/.injectived/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="inj"' > $HOME/.injectived/config/tmp_genesis.json && mv $HOME/.injectived/config/tmp_genesis.json $HOME/.injectived/config/genesis.json
cat $HOME/.injectived/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="inj"' > $HOME/.injectived/config/tmp_genesis.json && mv $HOME/.injectived/config/tmp_genesis.json $HOME/.injectived/config/genesis.json
echo "NOTE: Setting Governance Voting Period to 10 seconds for easy testing"
cat $HOME/.injectived/config/genesis.json | jq '.app_state["gov"]["voting_params"]["voting_period"]="10s"' > $HOME/.injectived/config/tmp_genesis.json && mv $HOME/.injectived/config/tmp_genesis.json $HOME/.injectived/config/genesis.json
cat $HOME/.injectived/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="inj"' > $HOME/.injectived/config/tmp_genesis.json && mv $HOME/.injectived/config/tmp_genesis.json $HOME/.injectived/config/genesis.json
cat $HOME/.injectived/config/genesis.json | jq '.app_state["auction"]["params"]["auction_period"]="10"' > $HOME/.injectived/config/tmp_genesis.json && mv $HOME/.injectived/config/tmp_genesis.json $HOME/.injectived/config/genesis.json
cat $HOME/.injectived/config/genesis.json | jq '.app_state["ocr"]["params"]["module_admin"]="'$FEEDADMIN'"' > $HOME/.injectived/config/tmp_genesis.json && mv $HOME/.injectived/config/tmp_genesis.json $HOME/.injectived/config/genesis.json
cat $HOME/.injectived/config/genesis.json | jq '.app_state["ocr"]["params"]["payout_block_interval"]="5"' > $HOME/.injectived/config/tmp_genesis.json && mv $HOME/.injectived/config/tmp_genesis.json $HOME/.injectived/config/genesis.json

INJ='{"denom":"inj","decimals":18}'

USDT='{"denom":"peggy0xdAC17F958D2ee523a2206206994597C13D831ec7","decimals":6}'
USDC='{"denom":"peggy0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48","decimals":6}'
ONEINCH='{"denom":"peggy0x111111111117dc0aa78b770fa6a738034120c302","decimals":18}'
AAVE='{"denom":"peggy0x7fc66500c84a76ad7e9c93437bfc5ac33e2ddae9","decimals":18}'
AXS='{"denom":"peggy0xBB0E17EF65F82Ab018d8EDd776e8DD940327B28b","decimals":18}'
BAT='{"denom":"peggy0x0D8775F648430679A709E98d2b0Cb6250d2887EF","decimals":18}'
BNB='{"denom":"peggy0xB8c77482e45F1F44dE1745F52C74426C631bDD52","decimals":18}'
WBTC='{"denom":"peggy0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599","decimals":8}'
BUSD='{"denom":"peggy0x4Fabb145d64652a948d72533023f6E7A623C7C53","decimals":18}'
CEL='{"denom":"peggy0xaaAEBE6Fe48E54f431b0C390CfaF0b017d09D42d","decimals":4}'
CELL='{"denom":"peggy0x26c8AFBBFE1EBaca03C2bB082E69D0476Bffe099","decimals":18}'
CHZ='{"denom":"peggy0x3506424F91fD33084466F402d5D97f05F8e3b4AF","decimals":18}'
COMP='{"denom":"peggy0xc00e94Cb662C3520282E6f5717214004A7f26888","decimals":18}'
DAI='{"denom":"peggy0x6B175474E89094C44Da98b954EedeAC495271d0F","decimals":18}'
DEFI5='{"denom":"peggy0xfa6de2697D59E88Ed7Fc4dFE5A33daC43565ea41","decimals":18}'
ENJ='{"denom":"peggy0xF629cBd94d3791C9250152BD8dfBDF380E2a3B9c","decimals":18}'
WETH='{"denom":"peggy0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2","decimals":18}'
EVAI='{"denom":"peggy0x50f09629d0afDF40398a3F317cc676cA9132055c","decimals":8}'
FTM='{"denom":"peggy0x4E15361FD6b4BB609Fa63C81A2be19d873717870","decimals":18}'
GF='{"denom":"peggy0xAaEf88cEa01475125522e117BFe45cF32044E238","decimals":18}'
GRT='{"denom":"peggy0xc944E90C64B2c07662A292be6244BDf05Cda44a7","decimals":18}'
HT='{"denom":"peggy0x6f259637dcD74C767781E37Bc6133cd6A68aa161","decimals":18}'
LINK='{"denom":"peggy0x514910771AF9Ca656af840dff83E8264EcF986CA","decimals":18}'
MATIC='{"denom":"peggy0x7D1AfA7B718fb893dB30A3aBc0Cfc608AaCfeBB0","decimals":18}'
NEXO='{"denom":"peggy0xB62132e35a6c13ee1EE0f84dC5d40bad8d815206","decimals":18}'
NOIA='{"denom":"peggy0xa8c8CfB141A3bB59FEA1E2ea6B79b5ECBCD7b6ca","decimals":18}'
OCEAN='{"denom":"peggy0x967da4048cD07aB37855c090aAF366e4ce1b9F48","decimals":18}'
PAXG='{"denom":"peggy0x45804880De22913dAFE09f4980848ECE6EcbAf78","decimals":18}'
POOL='{"denom":"peggy0x0cEC1A9154Ff802e7934Fc916Ed7Ca50bDE6844e","decimals":18}'
QNT='{"denom":"peggy0x4a220E6096B25EADb88358cb44068A3248254675","decimals":18}'
RUNE='{"denom":"peggy0x3155BA85D5F96b2d030a4966AF206230e46849cb","decimals":18}'
SHIB='{"denom":"peggy0x95aD61b0a150d79219dCF64E1E6Cc01f0B64C4cE","decimals":18}'
SNX='{"denom":"peggy0xC011a73ee8576Fb46F5E1c5751cA3B9Fe0af2a6F","decimals":18}'
STARS='{"denom":"peggy0xc55c2175E90A46602fD42e931f62B3Acc1A013Ca","decimals":18}'
STT='{"denom":"peggy0xaC9Bb427953aC7FDDC562ADcA86CF42D988047Fd","decimals":18}'
SUSHI='{"denom":"peggy0x6B3595068778DD592e39A122f4f5a5cF09C90fE2","decimals":18}'
SWAP='{"denom":"peggy0xCC4304A31d09258b0029eA7FE63d032f52e44EFe","decimals":18}'
UMA='{"denom":"peggy0x04Fa0d235C4abf4BcF4787aF4CF447DE572eF828","decimals":18}'
UNI='{"denom":"peggy0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984","decimals":18}'
UTK='{"denom":"peggy0xdc9Ac3C20D1ed0B540dF9b1feDC10039Df13F99c","decimals":18}'
YFI='{"denom":"peggy0x0bc529c00C6401aEF6D220BE8C6Ea1667F6Ad93e","decimals":18}'
ZRX='{"denom":"peggy0xE41d2489571d322189246DaFA5ebDe1F4699F498","decimals":18}'

ATOM='{"denom":"ibc/C4CFF46FD6DE35CA4CF4CE031E643C8FDC9BA4B99AE598E9B0ED98FE3A2319F9","decimals":6}'
USTC='{"denom":"ibc/B448C0CA358B958301D328CCDC5D5AD642FC30A6D3AE106FF721DB315F3DDE5C","decimals":6}'
AXL='{"denom":"ibc/C49B72C4E85AE5361C3E0F0587B24F509CB16ECEB8970B6F917D697036AF49BE","decimals":6}'
XPRT='{"denom":"ibc/B786E7CBBF026F6F15A8DA248E0F18C62A0F7A70CB2DABD9239398C8B5150ABB","decimals":6}'
SCRT='{"denom":"ibc/3C38B741DF7CD6CAC484343A4994CFC74BC002D1840AAFD5416D9DAC61E37F10","decimals":6}'
OSMO='{"denom":"ibc/92E0120F15D037353CFB73C14651FC8930ADC05B93100FD7754D3A689E53B333","decimals":6}'
LUNC='{"denom":"ibc/B8AF5D92165F35AB31F3FC7C7B444B9D240760FA5D406C49D24862BD0284E395","decimals":6}'
HUAHUA='{"denom":"ibc/E7807A46C0B7B44B350DA58F51F278881B863EC4DCA94635DAB39E52C30766CB","decimals":6}'
EVMOS='{"denom":"ibc/16618B7F7AC551F48C057A13F4CA5503693FBFF507719A85BC6876B8BD75F821","decimals":18}'
DOT='{"denom":"ibc/624BA9DD171915A2B9EA70F69638B2CEA179959850C1A586F6C485498F29EDD4","decimals":10}'

PEGGY_DENOM_DECIMALS="${USDT},${USDC},${ONEINCH},${AXS},${BAT},${BNB},${WBTC},${BUSD},${CEL},${CELL},${CHZ},${COMP},${DAI},${DEFI5},${ENJ},${WETH},${EVAI},${FTM},${GF},${GRT},${HT},${LINK},${MATIC},${NEXO},${NOIA},${OCEAN},${PAXG},${POOL},${QNT},${RUNE},${SHIB},${SNX},${STARS},${STT},${SUSHI},${SWAP},${UMA},${UNI},${UTK},${YFI},${ZRX}"
IBC_DENOM_DECIMALS="${ATOM},${USTC},${AXL},${XPRT},${SCRT},${OSMO},${LUNC},${HUAHUA},${EVMOS},${DOT}"
DENOM_DECIMALS='['${INJ},${PEGGY_DENOM_DECIMALS},${IBC_DENOM_DECIMALS}']'

cat $HOME/.injectived/config/genesis.json | jq '.app_state["exchange"]["denom_decimals"]='${DENOM_DECIMALS} > $HOME/.injectived/config/tmp_genesis.json && mv $HOME/.injectived/config/tmp_genesis.json $HOME/.injectived/config/genesis.json

yes $PASSPHRASE | injectived keys add genesis
yes $PASSPHRASE | injectived add-genesis-account --chain-id $CHAINID $(yes $PASSPHRASE | injectived keys show genesis -a) 1000000000000000000000000inj,1000000000000000000000000atom,100000000000000000000000000peggy0xdAC17F958D2ee523a2206206994597C13D831ec7,100000000000000000000000000peggy0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599
# zero address account
yes $PASSPHRASE | injectived add-genesis-account --chain-id $CHAINID inj1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqe2hm49 1inj

WASM_KEY="wasm"
WASM_MNEMONIC="juice dog over thing anger search film document sight fork enrich jungle vacuum grab more sunset winner diesel flock smooth route impulse cheap toward"

VAL_KEY="localkey"
VAL_MNEMONIC="gesture inject test cycle original hollow east ridge hen combine junk child bacon zero hope comfort vacuum milk pitch cage oppose unhappy lunar seat"

USER1_KEY="user1"
USER1_MNEMONIC="copper push brief egg scan entry inform record adjust fossil boss egg comic alien upon aspect dry avoid interest fury window hint race symptom"

USER2_KEY="user2"
USER2_MNEMONIC="maximum display century economy unlock van census kite error heart snow filter midnight usage egg venture cash kick motor survey drastic edge muffin visual"

USER3_KEY="user3"
USER3_MNEMONIC="keep liar demand upon shed essence tip undo eagle run people strong sense another salute double peasant egg royal hair report winner student diamond"

USER4_KEY="user4"
USER4_MNEMONIC="pony glide frown crisp unfold lawn cup loan trial govern usual matrix theory wash fresh address pioneer between meadow visa buffalo keep gallery swear"

USER5_KEY="ocrfeedadmin"
USER5_MNEMONIC="earn front swamp dune level clip shell aware apple spare faith upset flip local regret loud suspect view heavy raccoon satisfy cupboard harbor basic"

USER6_KEY="signer1"
USER6_MNEMONIC="output arrange offer advance egg point office silent diamond fame heart hotel rocket sheriff resemble couple race crouch kit laptop document grape drastic lumber"

USER7_KEY="signer2"
USER7_MNEMONIC="velvet gesture rule caution injury stick property decorate raccoon physical narrow tuition address drum shoot pyramid record sport include rich actress sadness crater seek"

USER8_KEY="signer3"
USER8_MNEMONIC="guitar parrot nuclear sun blue marble amazing extend solar device address better chalk shock street absent follow notice female picnic into trade brass couch"

USER9_KEY="signer4"
USER9_MNEMONIC="rotate fame stamp size inform hurdle match stick brain shrimp fancy clinic soccer fortune photo gloom wear punch shed diet celery blossom tide bulk"

USER10_KEY="signer5"
USER10_MNEMONIC="apart acid night more advance december weather expect pause taxi reunion eternal crater crew lady chaos visual dynamic friend match glow flash couple tumble"

NEWLINE=$'\n'

# Import keys from mnemonics
yes "$WASM_MNEMONIC$NEWLINE$PASSPHRASE" | injectived keys add $WASM_KEY --recover
yes "$VAL_MNEMONIC$NEWLINE$PASSPHRASE" | injectived keys add $VAL_KEY --recover
yes "$USER1_MNEMONIC$NEWLINE$PASSPHRASE" | injectived keys add $USER1_KEY --recover
yes "$USER2_MNEMONIC$NEWLINE$PASSPHRASE" | injectived keys add $USER2_KEY --recover
yes "$USER3_MNEMONIC$NEWLINE$PASSPHRASE" | injectived keys add $USER3_KEY --recover
yes "$USER4_MNEMONIC$NEWLINE$PASSPHRASE" | injectived keys add $USER4_KEY --recover
yes "$USER5_MNEMONIC$NEWLINE$PASSPHRASE" | injectived keys add $USER5_KEY --recover
yes "$USER6_MNEMONIC$NEWLINE$PASSPHRASE" | injectived keys add $USER6_KEY --recover
yes "$USER7_MNEMONIC$NEWLINE$PASSPHRASE" | injectived keys add $USER7_KEY --recover
yes "$USER8_MNEMONIC$NEWLINE$PASSPHRASE" | injectived keys add $USER8_KEY --recover
yes "$USER9_MNEMONIC$NEWLINE$PASSPHRASE" | injectived keys add $USER9_KEY --recover
yes "$USER10_MNEMONIC$NEWLINE$PASSPHRASE" | injectived keys add $USER10_KEY --recover

# Allocate genesis accounts (cosmos formatted addresses)
yes $PASSPHRASE | injectived add-genesis-account --chain-id $CHAINID $(injectived keys show $WASM_KEY -a) 1000000000000000000000inj
yes $PASSPHRASE | injectived add-genesis-account --chain-id $CHAINID $(injectived keys show $VAL_KEY -a) 1000000000000000000000inj
yes $PASSPHRASE | injectived add-genesis-account --chain-id $CHAINID $(injectived keys show $USER1_KEY -a) 1000000000000000000000inj,1000000000000000000000atom,100000000000000000000000000peggy0xdAC17F958D2ee523a2206206994597C13D831ec7,100000000000000000000000000peggy0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599
yes $PASSPHRASE | injectived add-genesis-account --chain-id $CHAINID $(injectived keys show $USER2_KEY -a) 1000000000000000000000inj,100000000000000000000000000peggy0xdAC17F958D2ee523a2206206994597C13D831ec7,100000000000000000000000000peggy0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599
yes $PASSPHRASE | injectived add-genesis-account --chain-id $CHAINID $(injectived keys show $USER3_KEY -a) 1000000000000000000000inj
yes $PASSPHRASE | injectived add-genesis-account --chain-id $CHAINID $(injectived keys show $USER4_KEY -a) 1000000000000000000000inj
yes $PASSPHRASE | injectived add-genesis-account --chain-id $CHAINID $(injectived keys show $USER5_KEY -a) 100000000000000000000000000inj
yes $PASSPHRASE | injectived add-genesis-account --chain-id $CHAINID $(injectived keys show $USER6_KEY -a) 100000000000000000000000000inj
yes $PASSPHRASE | injectived add-genesis-account --chain-id $CHAINID $(injectived keys show $USER7_KEY -a) 100000000000000000000000000inj
yes $PASSPHRASE | injectived add-genesis-account --chain-id $CHAINID $(injectived keys show $USER8_KEY -a) 100000000000000000000000000inj
yes $PASSPHRASE | injectived add-genesis-account --chain-id $CHAINID $(injectived keys show $USER9_KEY -a) 100000000000000000000000000inj
yes $PASSPHRASE | injectived add-genesis-account --chain-id $CHAINID $(injectived keys show $USER10_KEY -a) 100000000000000000000000000inj

echo "Signing genesis transaction"
# Sign genesis transaction
yes $PASSPHRASE | injectived genesis gentx genesis 1000000000000000000000inj --chain-id $CHAINID

echo "Collecting genesis transaction"
# Collect genesis tx
yes $PASSPHRASE | injectived genesis collect-gentxs

echo "Validating genesis"
# Run this to ensure everything worked and that the genesis file is setup correctly
injectived validate-genesis

echo "Setup done!"