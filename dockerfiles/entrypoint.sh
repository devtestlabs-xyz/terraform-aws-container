#!/bin/sh

set -e

# Change path to Terraform working directory
cd ${GITHUB_WORKSPACE}/${_TF_WORKING_DIR}

if [ "$1" = "show" ]; then 
  terraform init -input=false -backend-config="backend.hcl" -no-color
  _outcome=$(terraform $1 $2 2>&1); _exitcode=$?

elif [ "$1" = "init" ]; then
  _outcome=$(terraform $1 $2 2>&1); _exitcode=$?

elif [ "$1" = "fmt" ]; then 
  _outcome=$(terraform $1 $2 2>&1); _exitcode=$?

elif [ "$1" = "validate" ]; then 
  _outcome=$(terraform $1 $2 2>&1); _exitcode=$?

elif [ "$1" = "plan" ]; then 
  _outcome=$(terraform $1 $2 2>&1); _exitcode=$?

elif [ "$1" = "apply" ]; then
  _outcome=$(terraform $1 $2 2>&1); _exitcode=$?

# elif [ "$1" = "destroy" ]; then 
#   _outcome=$(terraform $1 $2 2>&1)

else
  echo "Command is not currently supported."; _exitcode=3
fi

# Fix for multi-line content
# Escape % and \n and \r, the runner will unescape in reverse.
# https://github.community/t/set-output-truncates-multiline-strings/16852
_outcome="${_outcome//'%'/'%25'}"
_outcome="${_outcome//$'\n'/'%0A'}"
_outcome="${_outcome//$'\r'/'%0D'}"
echo "::set-output name=outcome::$_outcome"
echo "::set-output name=exitcode::$_exitcode"
