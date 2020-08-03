#!/bin/sh

set -e

if [ $2 = "show" ]
then
  terraform init -input=false -backend-config="${GITHUB_WORKSPACE}/live/biz/consul-servers/backend.hcl" -no-color ${GITHUB_WORKSPACE}/live/biz/consul-servers
  terraform show -json -no-color "${GITHUB_WORKSPACE}/live/biz/consul-servers/${TFPLAN}"
else
  exec "$@"
fi