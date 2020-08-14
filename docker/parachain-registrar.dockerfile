FROM node:latest AS pjs


# To use the pjs build stage to access the blockchain from the host machine:
#
#   docker build -f docker/parachain-registrar.dockerfile --target pjs -t parachain-registrar:pjs .
#   alias pjs='docker run --rm --net cumulus_testing_net parachain-registrar:pjs --ws ws://172.28.1.1:9944'
#
# Then, as long as the chain is running, you can use the polkadot-js-api CLI like:
#
#   pjs query.sudo.key

FROM pjs
RUN apt-get update && apt-get install curl netcat -y && \
    curl -sSo /wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
    chmod +x /wait-for-it.sh
COPY ./register/ /var/tmp/register
RUN cd /var/tmp/register && yarn && chmod +x index.js
# the only thing left to do is to actually run the transaction.
COPY ./register_para.sh /usr/bin
# unset the previous stage's entrypoint
ENTRYPOINT []
CMD [ "/usr/bin/register_para.sh" ]
