#!/bin/bash
#
# Generate access keys for user:
# ./generate-access-keys.sh <username>
set -e

if [[ ! -e $(which aws) ]]; then
  echo "Please ensure you have aws cli tools installed"
  exit 1
fi

USERNAME=$1

if [[ ! $USERNAME ]]; then
  echo "Must set username"
  exit 1
fi

aws iam create-access-key --user-name $USERNAME
