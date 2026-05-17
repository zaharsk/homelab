# https://just.systems

secrets := '
keys/ssh.ubuntu
keys/ssh.ubuntu.pub
'

sops-encode:
    ./scripts/sops_encode.sh '{{ secrets }}'
