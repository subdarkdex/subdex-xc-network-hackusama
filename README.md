# DDEX XC network

## Pre-requisits
Docker version 19.03.8, build afacb8b

## Setup
`docker-compose up`

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

#### Genesis state of parachains
Currently, there is an issue with getting the genesis state in step 3 of the [https://github.com/paritytech/cumulus#running-a-collator](instruction), discussed in riot. Here are the genesis states used for registration. 

TODO: update genesis states

genesis state parachain
0x000000000000000000000000000000000000000000000000000000000000000000b548c13343eca33ba013648dfb48121
84264e0405e90ee8c80c659ddb60a294103170a2e7597b7b7e3d84c05391d139a62b157e78786d8c082f29dcf4c11131400

