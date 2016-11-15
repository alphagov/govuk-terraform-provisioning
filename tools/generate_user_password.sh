#!/bin/bash
#
# Generate a first-time user password:
# ./generate_user_password.sh <username>
set -e

if [[ ! -e $(which aws) ]]; then
  echo "Please ensure you have aws cli tools installed"
  exit 1
fi

USERNAME=$1
PASSWORD=$(openssl rand -hex 32)

if [[ ! ${USERNAME} ]]; then
  echo "Must set username"
  exit 1
fi

aws iam create-login-profile --password-reset-required --user-name ${USERNAME} --password ${PASSWORD}

echo "New password for ${USERNAME} set to: ${PASSWORD}"
