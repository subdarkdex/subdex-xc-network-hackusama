# DDEX XC network





___
## Development

### building all docker images for dockerhub

1. **Base images** - this is to compile the binary / wasm file from branches of subdarkdex_cumulus

```sh
cd dex-parachain # or generic-parachain
docker build --tag belsyuen/dex-chain:<version>
```

2. **Collator** - this will be the collator and also used to generate genesis state

```sh
docker build --file ./docker/dex-chain-collator.dockerfile --target collator --tag belsyuen/dex-collator:v0.1.0 ./docker
# will use use it like docker run collator /usr/bin/dex-chain export-genesis-state /data/genesis-state
```

3. **WASM Runtime** - this is a WASM runtime volume to register the parachain

```sh
docker build --file ./docker/dex-chain-collator.dockerfile --target runtime --tag belsyuen/dex-runtime:v0.1.0 ./docker
```

4. **Registrar** - this is the registrar 

```sh
docker build --file ./docker/parachain-registrar.dockerfile --tag belsyuen/dex-registrar:v0.1.0 ./docker
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


