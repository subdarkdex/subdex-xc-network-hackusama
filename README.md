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


### 1. Set up validators
`docker-compose up` will set up alice, bob, charlie and dave

### 2. build parachains
_This will take a WHILEEEEEEE_
```
./build_collators.sh
```

### 3. run the parachains
```
./start_collators.sh
```

### 4. register parachains
```
./register_parachain.sh
```

### 5. (purge-chains, all chains)
```
./clear_al.sh
```


## Setup config details
#### Chain specs
The DarkDex chain spec is a duplication of the westend-local chain, but with 4 validators and validator count as 4. Changes were made to v0.8.14 - chain_spec.rs

```sh
# westend-local was updated with 4 validators, Alice, Bob, Charlie and Dave
./target/release/polkadot build-spec --chain=westend-local --raw --disable-default-bootnode > ddex_raw.json
```

___
## App

This is currently a playground. 

```
cd app
yarn
```


