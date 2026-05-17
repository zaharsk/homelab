#!/bin/bash

set -ueo pipefail

SECRETS_PATH="${WORKSPACE_FOLDER}/${SECRETS_FOLDER}"

mkdir -p "${SECRETS_PATH}"

age-keygen -o "${WORKSPACE_FOLDER}/${SOPS_AGE_KEY_FILE}"
ssh-keygen -t ed25519 -C "ubuntu@homelab" -N "" -f "${SECRETS_PATH}/ssh.ubuntu"
