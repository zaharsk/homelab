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
'

secrets-encode:
    ./scripts/sops_encode.sh '{{ secrets }}'

secrets-decode:
    ./scripts/sops_decode.sh '{{ secrets }}'

tf-infra-init:
    terraform -chdir=${WORKSPACE_FOLDER}/terraform/infra init \
        -upgrade \
        -reconfigure \
        -backend-config="${WORKSPACE_FOLDER}/${SECRETS_FOLDER}/tfbackend.cf-r2.hcl" 
