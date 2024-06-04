#!/usr/bin/env sh

set -xe

# =============================== wireguard ===================================
echo "162.159.192.1 engage.cloudflareclient.com" >> /etc/hosts
./wgcf-docker.sh

# ================================= server ====================================
node index
