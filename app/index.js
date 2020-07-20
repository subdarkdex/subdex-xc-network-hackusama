const { ApiPromise, WsProvider } = require('@polkadot/api');
const { Keyring } = require('@polkadot/keyring');


const wsProvider = new WsProvider('ws://127.0.0.1:7744');

const Charlie = "5FLSigC9HGRKVhB9FiEo4Y3koPsNmBmLJbpXg2mp1hXcS59Y"
async function main () {
    const api = await ApiPromise.create({ 
        provider: wsProvider,
        types: { 
            Address: 'AccountId', 
            LookupSource: 'AccountId', 
            RelayChainBlockNumber: 'BlockNumber',
            ValidationFunction: 'Vec<u8>'
        }
     });

    // TODO  type
    // pub struct ValidationFunctionParams {
    //     /// The maximum code size permitted, in bytes.
    //     pub max_code_size: u32,
    //     /// The current relay-chain block number.
    //     pub relay_chain_height: RelayChainBlockNumber,
    //     /// Whether a code upgrade is allowed or not, and at which height the upgrade
    //     /// would be applied after, if so. The parachain logic should apply any upgrade
    //     /// issued in this block after the first block
    //     /// with `relay_chain_height` at least this value, if `Some`. if `None`, issue
    //     /// no upgrade.
    //     pub code_upgrade_allowed: Option<RelayChainBlockNumber>,
    // }
    const keyring = new Keyring({ type: 'sr25519' });
    const alice = keyring.addFromUri('//Alice');

    // This is currently invalid
    const unsub = await api.tx.tokenDealer.transferTokensToRelayChain(Charlie, 12345)
    .signAndSend(alice, ({ events = [], status }) => {
        console.log(`Current status is ${status.type}`);
    
        if (status.isFinalized) {
          console.log(`Transaction included at blockHash ${status.asFinalized}`);
    
          // Loop through Vec<EventRecord> to display all events
          events.forEach(({ phase, event: { data, method, section } }) => {
            console.log(`\t' ${phase}: ${section}.${method}:: ${data}`);
          });
    
          unsub();
        }
  })
};
  
  main()