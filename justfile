# https://just.systems

secrets := '
keys/ssh.ubuntu
keys/ssh.ubuntu.pub
'

secrets-encode:
    ./scripts/sops_encode.sh '{{ secrets }}'

secrets-decode:
    ./scripts/sops_decode.sh '{{ secrets }}'
