# https://just.systems

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

decrypt file_path:
    file_name=$(basename "{{ file_path }}") && \
    sops decrypt "{{ file_path }}" > "/dev/shm/$file_name"
