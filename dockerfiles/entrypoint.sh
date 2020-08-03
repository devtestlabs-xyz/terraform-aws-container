#!/bin/sh

set -e

if [ $2 = "show" ]
then
  cd ${GITHUB_WORKSPACE}/live/biz/consul-servers
  terraform init -input=false -backend-config="backend.hcl" -no-color
  _outcome=$(terraform show -json -no-color ${TFPLAN} 2>&1)
else
  _outcome=$(exec "$@" 2>&1)
fi

echo "::set-output name=outcome::$_outcome"