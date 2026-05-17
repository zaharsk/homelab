# https://just.systems

secrets := '
keys/ssh.ubuntu
keys/ssh.ubuntu.pub
keys/tfbackend.cf-r2.hcl
'

secrets-encode:
    ./scripts/sops_encode.sh '{{ secrets }}'

secrets-decode:
    ./scripts/sops_decode.sh '{{ secrets }}'

tf-init:
    terraform -chdir=$WORKSPACE_FOLDER/terraform init -upgrade -reconfigure -backend-config="../keys/tfbackend.cf-r2.hcl" 
