#!/usr/bin/env bash

set -euo pipefail

read -rsp "Paste AGE-SECRET-KEY or press Enter to start without decrypting secrets: " AGE_KEY
echo

if [ -z "${AGE_KEY}" ]; then
    cat <<'EOF'

AGE-SECRET-KEY was not provided. Secrets were not decrypted.

You can run the script again at any time with:

    ./scripts/decrypt_secrets.sh

EOF
    exit 0
fi

mkdir -p "$(dirname "${SOPS_AGE_KEY_FILE}")"

printf '%s\n' "${AGE_KEY}" > "${SOPS_AGE_KEY_FILE}"
chmod 600 "${SOPS_AGE_KEY_FILE}"

find "${SECRETS_PATH}" -type f | while read -r encrypted_file_path; do
    encrypted_file=$(basename "${encrypted_file_path}")
    output_file="/dev/shm/${encrypted_file}"
    sops decrypt "${encrypted_file_path}" > "${output_file}"
    chmod 600 "${output_file}"
done

echo "All the secrets were successfully decrypted. Don’t forget to exit the editor when you’re finished."