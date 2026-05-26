#!/usr/bin/env bash

set -ueo pipefail

git config --global user.name "${GIT_USER_NAME}"
git config --global user.email "${GIT_USER_EMAIL}"

git config --global core.autocrlf input
git config --global core.symlinks true

git config --global pull.rebase true

if ssh-add -L >/dev/null 2>&1; then
    mkdir -p ~/.ssh

    ssh-add -L | head -n1 > ~/.ssh/id_ed25519.pub

    git config --global gpg.format ssh
    git config --global user.signingkey ~/.ssh/id_ed25519.pub
    git config --global commit.gpgsign true
else
    echo "SSH agent is unavailable or no identities are loaded."
    echo "Git commit signing was skipped."
fi

ansible-galaxy collection install -r ./ansible/requirements.yml

./scripts/decrypt_secrets.sh