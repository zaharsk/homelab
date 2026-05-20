#!/usr/bin/env bash

set -ueo pipefail

git config --global user.name "${GIT_USER_NAME}"
git config --global user.email "${GIT_USER_EMAIL}"
git config --global pull.rebase true

mkdir -p ~/.ssh

ssh-add -L | head -n1 > ~/.ssh/id_ed25519.pub

git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ed25519.pub
git config --global commit.gpgsign true

./scripts/decrypt_secrets.sh