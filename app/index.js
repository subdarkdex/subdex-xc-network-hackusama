const { ApiPromise, WsProvider } = require("@polkadot/api");
const { Keyring } = require("@polkadot/keyring");
const wsProvider = new WsProvider("ws://127.0.0.1:7744");
const Charlie = "5FLSigC9HGRKVhB9FiEo4Y3koPsNmBmLJbpXg2mp1hXcS59Y"
async function main () {
    const api = await ApiPromise.create({ 
        provider: wsProvider,
        types: {
            "AssetId": "u64",
            "Address": "AccountId", 
            "LookupSource": "AccountId", 
            "RelayChainBlockNumber": "BlockNumber",
            "ValidationFunction": "Vec<u8>",
            "ValidationFunctionParams": {
              "max_code_size": "u32",
              "relay_chain_height": "RelayChainBlockNumber",
              "code_upgrade_allowed": "Option<RelayChainBlockNumber>"
            }
        }
     });

    const keyring = new Keyring({ type: "sr25519" });
    const alice = keyring.addFromUri("//Alice");

    // This is currently invalid
    const unsub = await api.tx.balances.transfer(Charlie, 100)
    .signAndSend(alice, (result) => {
        console.log(`Current result is ${JSON.stringify(result)}`);
    })
};
  
  main()