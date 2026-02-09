#!/usr/bin/env bash
openssl rand 10 \
| base32 \
| tr 'A-Z2-7' 'a-z2-7' \
| cut -c1-10 \
| sed 's/.\{5\}/&-/'
