#!/bin/bash
set -e
set -x
export DEVPI_SERVERDIR=/mnt
export DEVPI_CLIENTDIR=/tmp/devpi-client
[[ -f $DEVPI_SERVERDIR/.serverversion ]] || initialize=yes

devpi-server --start --host 0.0.0.0 --port 3141
if [[ "X$initialize" = "Xyes" ]]; then
  devpi use http://0.0.0.0:3141
  devpi login root --password=''
  devpi user -m root password="${DEVPI_PASSWORD}"
  devpi index -y -c public pypi_whitelist='*'
fi
tail -f $DEVPI_SERVERDIR/.xproc/devpi-server/xprocess.log
