#!/usr/bin/env sh
set -e

if systemctl is-active --quiet wireguard-kybe.xyz.service; then
    sudo systemctl stop wireguard-kybe.xyz.service
else
    sudo systemctl start wireguard-kybe.xyz.service
fi
