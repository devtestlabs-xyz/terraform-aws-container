#!/bin/sh

set -e

#STDOUT_FILE="_stdout"
#touch $STDOUT_FILE

cd ${GITHUB_WORKSPACE}/${_TF_CONFIG_PATH}

#exec &> >(tee -a "$STDOUT_FILE")

if [ "$2" = "show" ]; then 
  terraform init -input=false -backend-config="backend.hcl" -no-color
#   terraform show -json -no-color ${TFPLAN}
  _outcome=$(terraform show $3)
elif [ "$2" = "init" ]; then
  _outcome=$(exec "$@")
elif [ "$2" = "fmt" ]; then 
  _outcome=$(exec "$@")
elif [ "$2" = "validate" ]; then 
  _outcome=$(exec "$@")
elif [ "$2" = "plan" ]; then 
  _outcome=$(exec "$@")
elif [ "$2" = "apply" ]; then
  _outcome=$(exec "$@")
elif [ "$2" = "destroy" ]; then 
  _outcome=$(exec "$@")
else
  echo "Command is not currently supported."
fi

echo "::set-output name=outcome::$_outcome"