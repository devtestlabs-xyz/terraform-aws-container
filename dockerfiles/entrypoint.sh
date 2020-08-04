#!/bin/sh

set -e

#STDOUT_FILE="_stdout"
#touch $STDOUT_FILE

cd ${GITHUB_WORKSPACE}/${_TF_CONFIG_PATH}

#exec &> >(tee -a "$STDOUT_FILE")

if [ "$2" = "show" ]; then 
  terraform init -input=false -backend-config="backend.hcl" -no-color
#   terraform show -json -no-color ${TFPLAN}
  _outcome=$(terraform "$@")
elif [ "$2" = "init" ]; then
  _outcome=$(terraform "$@")
elif [ "$2" = "fmt" ]; then 
  _outcome=$(terraform "$@")
elif [ "$2" = "validate" ]; then 
  _outcome=$(terraform "$@")
elif [ "$2" = "plan" ]; then 
  _outcome=$(terraform "$@")
elif [ "$2" = "apply" ]; then
  _outcome=$(terraform "$@")
elif [ "$2" = "destroy" ]; then 
  _outcome=$(terraform "$@")
else
  echo "Command is not currently supported."
fi

echo "::set-output name=outcome::$_outcome"