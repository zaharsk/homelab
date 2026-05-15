#!/bin/bash

set -ueo pipefail

KEYS_FOLDER="${WORKSPACE_FOLDER}/keys"

mkdir -p ${KEYS_FOLDER}

ssh-keygen -t ed25519 -C "ubuntu@homelab" -N "" -f ${KEYS_FOLDER}/ssh.ubuntu
age-keygen -o ${KEYS_FOLDER}/age.key
