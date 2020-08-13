FROM subdarkdex/generic-chain:v0.1.0 as generic

FROM debian:buster-slim as collator
RUN apt-get update && apt-get install jq curl bash -y && \
    curl -sSo /wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
    chmod +x /wait-for-it.sh && \
    curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get install -y nodejs && \
    npm install --global yarn && \
    yarn global add @polkadot/api-cli@0.18.1
COPY --from=generic \
    /generic_chain/target/release/generic-parachain /usr/bin
COPY ./start_generic_collator.sh /usr/bin


FROM debian:buster-slim as runtime
COPY --from=generic \
    /generic_chain/target/release/wbuild/generic-parachain-runtime/generic_parachain_runtime.compact.wasm \
    /var/opt/
RUN mkdir /runtime
RUN cp -v /var/opt/generic_parachain_runtime.compact.wasm /runtime