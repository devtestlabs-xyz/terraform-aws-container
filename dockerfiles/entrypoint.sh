#!/bin/sh

set -e

if [ $2 = "show" ]
then
  cd ${GITHUB_WORKSPACE}/live/biz/consul-servers
  terraform init -input=false -backend-config="backend.hcl" -no-color
  _outcome=$(terraform show -json -no-color ${TFPLAN} | jq 1>)
else
  exec "$@"
fi

echo "::set-output name=outcome::$_outcome"