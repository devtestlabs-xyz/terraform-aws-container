#!/bin/sh

set -e

_STDOUT_FILE="_stdout"

cd ${GITHUB_WORKSPACE}/${_TF_CONFIG_PATH}

if [ $2 = "show" ]; then 
  terraform init -input=false -backend-config="backend.hcl" -no-color
#   terraform show -json -no-color ${TFPLAN}
  exec "$@"
elif [ $2 = "init" ]; then
  exec "$@"
elif [ $2 = "fmt" ]; then 
  exec "$@"
elif [ $2 = "validate" ]; then 
  exec "$@"
elif [ $2 = "plan" ]; then 
  exec "$@"
elif [ $2 = "apply" ]; then
  exec "$@"
elif [ $2 = "destroy" ]; then 
  exec "$@"
else
  echo "Command is not currently supported."
fi

# exec >/dev/tty

_outcome=$(cat $_STDOUT_FILE)
echo "::set-output name=outcome::$_outcome"