#!/usr/bin/env bash
set -euo pipefail

SECRETS="$1"

while IFS= read -r file; do
    [ -z "$file" ] && continue

    dir=$(dirname "$file")
    base=$(basename "$file")

    if [[ "$base" == *.* ]]; then
        name="${base%.*}"
        ext="${base##*.}"

        enc_file="$dir/${name}.enc.${ext}"
    else
        enc_file="$dir/${base}.enc"
    fi

    if [ ! -f "$enc_file" ]; then
        echo "Skipping missing encrypted file: $enc_file"
        continue
    fi

    echo "Decrypting $enc_file -> $file"

    sops decrypt "$enc_file" > "$file"

done <<< "$SECRETS"