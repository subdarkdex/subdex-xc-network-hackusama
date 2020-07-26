# DDEX XC network

## Pre-requisits
- Docker version 19.03.8, build afacb8b
- polkadot-api-js: `yarn global add @polkadot/api-cli@0.16.2`
- execute access for the `.sh` files in this repo

## Setup for dev

*NOTE:* - we are not using the script provided in cumulus because we want 2 parachains, also, need to be able to build and rebuild the parachain binaries as we experiment. But when we get more familiar / more stable versions of the parachains, we can build a similar script to do all steps. 

Steps required are:-
1. set up relay chain validators
1. set up default cumulus parachain 
1. run paraA and paraB
1. register parachains


### validators
`docker-compose up` will set up alice and bob

### build parachains
```
./build_collators.sh
```
Currently only one collator

### run the parachains
```
./start_collators.sh
```
Currently only one collator

### register parachains
```
./register_parachain.sh
```


## Setup config details
#### Chain specs
The DarkDex chain spec is a duplication of the westend-local chain, you can generate it with the following script. 

```
./target/release/polkadot build-spec --disable-default-bootnode --chain westend-local > westend_local.json

if [[ "$OSTYPE" == "darwin"* ]]; then
	sed -i '' 's/Westend Local Testnet/DarkDex Local Testnet/' westend_local.json
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
	sed -i 's/Westend Local Testnet/DarkDex Local Testnet/' westend_local.json
fi

./target/release/polkadot build-spec --chain=westend_local.json --raw --disable-default-bootnode > ddex_raw.json
```

___
## App

This is currently a playground. 

```
cd app
yarn
```


