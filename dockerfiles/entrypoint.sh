#!/bin/sh

set -e

if [ $2 = "show" ]
then
  cd ${GITHUB_WORKSPACE}/live/biz/consul-servers
  terraform init -input=false -backend-config="backend.hcl" -no-color
  terraform show -json -no-color ${TFPLAN}
else
  exec "$@"
fi