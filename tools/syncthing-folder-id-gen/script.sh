#!/usr/bin/env bash

n=${1:-1}
for ((i=0;i<n;i++)); do
    openssl rand 10 \
        | base32 \
        | tr 'A-Z2-7' 'a-z2-7' \
        | cut -c1-10 \
        | sed 's/.\{5\}/&-/'
done
