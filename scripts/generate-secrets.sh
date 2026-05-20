#!/usr/bin/env bash

set -ueo pipefail

mkdir -p "${SECRETS_PATH}"

age-keygen -o "${SOPS_AGE_KEY_FILE}"
ssh-keygen -t ed25519 -C "ubuntu@homelab" -N "" -f "/dev/shm/ubuntu_ed25519"
sops encrypt \
    --age $(age-keygen -y "${SOPS_AGE_KEY_FILE}") \
    /dev/shm/ubuntu_ed25519 > "${SECRETS_PATH}/ubuntu_ed25519"

sops encrypt \
    --age $(age-keygen -y "${SOPS_AGE_KEY_FILE}") \
    /dev/shm/ubuntu_ed25519.pub > "${SECRETS_PATH}/ubuntu_ed25519.pub"