#!/usr/bin/env sh

set -xe

# =============================== wireguard ===================================
if [ `grep -c "162.159.192.1 engage.cloudflareclient.com" /etc/hosts` == '0' ]; then
  echo "162.159.192.1 engage.cloudflareclient.com" >> /etc/hosts
fi

[[ "$CF" == "true" ]] && ./wgcf-docker.sh

# ================================= server ====================================
node index
