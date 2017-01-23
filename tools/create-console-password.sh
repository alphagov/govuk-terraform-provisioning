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

PASSWORD=$(openssl rand -base64 24)

aws iam create-login-profile --user-name $USERNAME --password $PASSWORD --password-reset-required

echo "Created password for ${1} as:"
echo "${PASSWORD}"
echo "User will have to reset password on login"
