#!/bin/sh

set -e

if ["$1" = 'show']
then
  init -input=false -backend-config="./live/biz/consul-servers/backend.hcl" -no-color ./live/biz/consul-servers
  show -json -no-color ./live/biz/consul-servers/${TFPLAN}
else
  exec "$@"
fi