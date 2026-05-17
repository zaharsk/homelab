# https://just.systems

secrets := '
secrets/ssh.ubuntu
secrets/ssh.ubuntu.pub
secrets/tfbackend.cf-r2.hcl
'

secrets-encode:
    ./scripts/sops_encode.sh '{{ secrets }}'

secrets-decode:
    ./scripts/sops_decode.sh '{{ secrets }}'

tf-init:
    terraform -chdir=${WORKSPACE_FOLDER}/terraform init \
        -upgrade \
        -reconfigure \
        -backend-config="${WORKSPACE_FOLDER}/${SECRETS_FOLDER}/tfbackend.cf-r2.hcl" 
