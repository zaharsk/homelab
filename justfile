# https://just.systems

secrets := '
secrets/ssh.ubuntu
secrets/ssh.ubuntu.pub
secrets/tfbackend.cf-r2.hcl
secrets/gcp.zulu.pem
secrets/oci.delta.pem
secrets/oci.zulu.pem
terraform/terraform.tfvars
terraform/gcp_zulu.auto.tfvars
terraform/oci_delta.auto.tfvars
terraform/oci_zulu.auto.tfvars
secrets/ansible.vars.yml
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
