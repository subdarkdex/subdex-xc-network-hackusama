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

To register a parachain we will need that parachain_id, the runtime wasm and genesis state. Currently, there is an issue with getting the genesis state in step 3 of the [instruction](https://github.com/paritytech/cumulus#running-a-collator), discussed in riot. So we will have to do it manually with So we will have to do it manually for now. 

After you run `./start_collators.sh`, you can find the genesis state from the log. Copy the genesis state, it will look something like this

```
2020-07-20 12:33:21 Parachain id: Id(100)
2020-07-20 12:33:21 Parachain Account: 5Ec4AhP7HwJNrY2CxEcFSy1BuqAY3qxvCQCfoois983TTxDA
2020-07-20 12:33:21 Parachain genesis state: 0x000000000000000000000000000000000000000000000000000000000000000000a6239dc05a4013dddbb51d786fdf3153c3ca0f20295adf64e3ad48abb229cbe103170a2e7597b7b7e3d84c05391d139a62b157e78786d8c082f29dcf4c11131400
```

copy the id and genesis state into `register_parachain.sh`, also be sure you are pointing to the correct wasm file for the parachain that you are registering for (currently generic_parachain)

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


