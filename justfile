# https://just.systems

encrypt file_path:
    file_name=$(basename "{{ file_path }}") && \
    sops encrypt \
        --age $(age-keygen -y "${SOPS_AGE_KEY_FILE}") \
        "{{ file_path }}" > "${WORKSPACE_FOLDER}/secrets/$file_name"

decrypt file_path:
    file_name=$(basename "{{ file_path }}") && \
    sops decrypt "{{ file_path }}" > "/dev/shm/$file_name"
