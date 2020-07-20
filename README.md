# DDEX XC network

## Pre-requisits
Docker version 19.03.8, build afacb8b

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
build_collators.sh
```

### run the parachains
```
start_collators.sh
```

### register parachains

TODO: script


To register a parachain we will need that parachain_id and the genesis state. Currently, there is an issue with getting the genesis state in step 3 of the [instruction](https://github.com/paritytech/cumulus#running-a-collator), discussed in riot. So we will have to do it manually with UI for now. You can see both after you start the `start_collators.sh`, it will be something like this... 

```
2020-07-20 12:33:21 Parachain id: Id(100)
2020-07-20 12:33:21 Parachain Account: 5Ec4AhP7HwJNrY2CxEcFSy1BuqAY3qxvCQCfoois983TTxDA
2020-07-20 12:33:21 Parachain genesis state: 0x000000000000000000000000000000000000000000000000000000000000000000a6239dc05a4013dddbb51d786fdf3153c3ca0f20295adf64e3ad48abb229cbe103170a2e7597b7b7e3d84c05391d139a62b157e78786d8c082f29dcf4c11131400
```

1. Go to https://polkadot.js.org/apps/#/explorer
1. Swtich to local net port 9944 if not already on it
1. Go to the Sudo tab, choose extrinsic method `registrar_registerPara`
1. parachain id: the id displayed, i.e. 100
1. scheduling - always
1. code: click to upload `/ddex_net/ddex_cumulus/target/release/wbuild/generic_parachain_runtime/generic_parachain_runtime.compact.wasm
1. inital head data: the genesis state found above
1. sign with the wallet, if you do not already have alice, add a new account with her private key `0xe5be9a5092b81bca64be81d212e7f2f9eba183bb7a90954f7b76361f6edb5c0a`


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



