#!/usr/bin/env bash

set -e

VERSION=$1

#Dex-collator
docker build \
    --file ./dex-chain-collator.dockerfile \
    --target collator \
    --tag belsyuen/dex-collator:"$VERSION" \
    .

#Generic-collator
docker build \
    --file ./generic-chain-collator.dockerfile \
    --target collator \
    --tag belsyuen/generic-collator:"$VERSION" \
    .

# Dex-runtime
docker build \
    --file ./dex-chain-collator.dockerfile \
    --target runtime \
    --tag belsyuen/dex-runtime:"$VERSION" \
    .

# Generic-runtime
docker build \
    --file ./generic-chain-collator.dockerfile \
    --target runtime \
    --tag belsyuen/geneic-runtime:"$VERSION" \
    .

# Registrar
docker build \
    --file ./parachain-registrar.dockerfile \
    --tag belsyuen/dex-registrar:"$VERSION" \
    .

docker rmi $(docker images | grep "<none>" | awk "{print $3}")
