# https://just.systems

secrets := '
secrets/ssh.ubuntu
secrets/ssh.ubuntu.pub
secrets/tfbackend.cf-r2.hcl
secrets/gcp.zulu.pem
secrets/oci.delta.pem
secrets/oci.zulu.pem
terraform/infra/terraform.tfvars
terraform/infra/gcp_zulu.auto.tfvars
terraform/infra/oci_delta.auto.tfvars
terraform/infra/oci_zulu.auto.tfvars
secrets/ansible.vars.yml
terraform/vault/terraform.tfvars
'

secrets-encode:
    ./scripts/sops_encode.sh '{{ secrets }}'

secrets-decode:
    ./scripts/sops_decode.sh '{{ secrets }}'

infra-tf-init:
    terraform -chdir=${WORKSPACE_FOLDER}/terraform/infra init \
        -upgrade \
        -reconfigure \
        -backend-config="${WORKSPACE_FOLDER}/${SECRETS_FOLDER}/tfbackend.cf-r2.hcl"

vault-tf-init:
    terraform -chdir=${WORKSPACE_FOLDER}/terraform/vault init \
        -upgrade \
        -reconfigure \
        -backend-config="${WORKSPACE_FOLDER}/${SECRETS_FOLDER}/tfbackend.cf-r2.hcl"

encrypt file_path:
    file_name=$(basename "{{ file_path }}") && \
    sops encrypt \
        --age $(age-keygen -y "${SOPS_AGE_KEY_FILE}") \
        "{{ file_path }}" > "${WORKSPACE_FOLDER}/secrets/$file_name"
