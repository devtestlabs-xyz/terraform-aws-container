#!/bin/sh

set -e

exec >_stdout

if [ $2 = "show" ]
then
  cd ${GITHUB_WORKSPACE}/live/biz/consul-servers
#   terraform init -input=false -backend-config="backend.hcl" -no-color
  terraform show -json -no-color ${TFPLAN}
else
  exec "$@"
fi

exec >/dev/tty
_outcome=$(cat _stdout)
echo "::set-output name=outcome::$_outcome"