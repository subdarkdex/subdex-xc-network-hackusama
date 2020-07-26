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
            ValidationFunction: 'Vec<u8>',
            ValidationFunctionParams: {
              max_code_size: 'u32',
              relay_chain_height: 'RelayChainBlockNumber',
              code_upgrade_allowed: 'Option<RelayChainBlockNumber>'
            }
        }
     });

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