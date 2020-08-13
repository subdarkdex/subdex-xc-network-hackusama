# Subdex cross chain network

This repo provides simple scripts, inspired by polkadot/cumulus, to set up a network with:-
1. Relay Chain with 4 validators (Alice, Bob, Charlie and Dave)
2. Generic parachain (test parachain in cumulus)
3. Subdex parachain (parachain with generic-asset and dex pallets)

The relay chain chain-specs is a modified version of westend_local, with `validator_count = 4` to support 2 parachains.


This is a part of the submission for Hackusama 2020. 
1. subdex-chain (Standalone dex-pallet in a substrate node)
2. subdex-ui (React frontend providing friendly UI)
3. **subdex-xc-network** (current repo)
4. subdex-cumulus (Parachains using the Cumulus framework, generic-parachain and dex_chain branches)

#### To run with docker
```sh
# in the root of this directory
docker-compose --file docker-compose-xc.yml up
```

#### To stop
```sh
# in the root of this directory
docker-compose --file docker-compose-xc.yml down -v
./clear_all.sh 
```

___
## Development

### building all docker images for dockerhub

1. **Base images** - this is to compile the binary / wasm file from branches of subdex_cumulus

```sh
 # or generic-parachain
git clone https://github.com/subdarkdex/subdex_cumulus.git dex-parachain
git checkout dex_chain
cd dex-parachain
docker build --tag belsyuen/dex-chain:<version>
```

2. **Collators, WASM Runtime Volume, Registrar**
- collators - both dex and generic parachains
- wasm runtime volume - this is a copy of the wasm runtime for the collators, used to register parachain, we also have the genesis state volume built during docker-compose up for this purpose
- registrar - simple polkadotjs cli container to register the parachains using sudo


```sh
cd docker
./build-containers.sh v0.1.0 
# or other versions
```

## Run local parachain binarys
### Pre-requisits
- Docker version 19.03.8, build afacb8b
- polkadot-api-js: `yarn global add @polkadot/api-cli@0.18.1`
- execute access for the `.sh` files in this repo

### Setup for native parachain binaries

*NOTE:* - we are not using the script provided in cumulus because we want 2 parachains, also, need to be able to build and rebuild the parachain binaries as we experiment. But when we get more familiar / more stable versions of the parachains, we can build a similar script to do all steps. 

Steps required are:-
1. set up relay chain validators
1. set up default cumulus parachain 
1. run paraA and paraB
1. register parachains


### 1. Set up validators
`docker-compose -f docker-compose-validatorsOnly.yml up` will set up alice, bob, charlie and dave

### 2. build parachains
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

### 5. stop validators
`docker-compose -f docker-compose-validatorsOnly.yml down`

### 6. (purge-chains, all chains)
```
./clear_al.sh
```


## Setup config details
#### Parachain account

The parachain account is tied to the `parachain_id` [encoded](https://github.com/paritytech/polkadot/blob/master/parachain/src/primitives.rs#L164)

```
 Parachain id: Id(100)
 Parachain Account: 5Ec4AhP7HwJNrY2CxEcFSy1BuqAY3qxvCQCfoois983TTxDA
... 
 Parachain id: Id(200)
 Parachain Account: 5Ec4AhPTL6nWnUnw58QzjJvFd3QATwHA3UJnvSD4GVSQ7Gop
```


#### Chain specs
The DarkDex chain spec is a duplication of the westend-local chain, but with 4 validators and validator count as 4. Changes were made to v0.8.14 - chain_spec.rs

```sh
# westend-local was updated with 4 validators, Alice, Bob, Charlie and Dave
./target/release/polkadot build-spec --chain=westend-local --raw --disable-default-bootnode > dex_raw.json
```

___
## App

This is currently a playground. 

```
cd app
yarn
```


