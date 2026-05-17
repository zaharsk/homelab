#!/usr/bin/env bash

set -euo pipefail

### Check .gitignore file and update if necessary #############################

SECRETS="$1"
START_MARKER="### START SOPS ###"
END_MARKER="### END SOPS ###"

touch .gitignore

TMP_FILE=$(mktemp)

{
    echo "${START_MARKER}"

    echo "${SOPS_AGE_KEY_FILE}"

    while IFS= read -r file; do
        [ -z "$file" ] && continue
        echo "$file"
    done <<< "${SECRETS}"

    echo "!*.enc.*"
    echo "!*.enc"

    echo "${END_MARKER}"
} > "${TMP_FILE}"



if grep -qF "${START_MARKER}" .gitignore; then
    awk '
        BEGIN { skip=0 }
        $0 == "'"${START_MARKER}"'" {
            skip=1
            while ((getline line < "'"${TMP_FILE}"'") > 0)
                print line
            next
        }

        $0 == "'"${END_MARKER}"'" {
            skip=0
            next
        }

        !skip { print }
    ' .gitignore > .gitignore.tmp

    mv .gitignore.tmp .gitignore
else
    {
        cat .gitignore
        echo
        echo
        cat "${TMP_FILE}"
    } > .gitignore.tmp
    mv .gitignore.tmp .gitignore
fi

rm -f "${TMP_FILE}"

### Encrypt secrets ###########################################################
if [ -z "${SOPS_AGE_KEY_FILE:-}" ]; then
    echo "SOPS_AGE_KEY_FILE is not set"
    exit 1
fi

if [ ! -f "${SOPS_AGE_KEY_FILE}" ]; then
    echo "AGE key file not found: ${SOPS_AGE_KEY_FILE}"
    exit 1
fi

AGE_PUBLIC_KEY=$(age-keygen -y "${SOPS_AGE_KEY_FILE}")

while IFS= read -r file; do
    [ -z "${file}" ] && continue
    if [ ! -f "${file}" ]; then
        echo "Skipping missing file: ${file}"
        continue
    fi

    dir=$(dirname "${file}")
    base=$(basename "${file}")

    if [[ "$base" == *.* ]]; then
        name="${base%.*}"
        ext="${base##*.}"
        enc_file="${dir}/${name}.enc.${ext}"
    else
        enc_file="${dir}/${base}.enc"
    fi
        
    echo "Encrypting ${file} -> ${enc_file}"

    sops encrypt --age "${AGE_PUBLIC_KEY}" "${file}" > "${enc_file}"

done <<< "${SECRETS}"