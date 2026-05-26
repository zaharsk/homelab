#!/usr/bin/env bash

set -ueo pipefail

if ! ssh-add -l; then
    echo "Add new key"
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519  
fi