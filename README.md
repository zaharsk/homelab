# Oracle Cloud based virtual Homelab

## Preparation

### 1. Generate keys:

```sh
./scripts/generate-secrets.sh
```

### 2. Terraform init

```bash
terraform init -upgrade -reconfigure -backend-config=s3.tfbackend.json
```

### 3. Create secrets

```bash
code /dev/shm/secret.yml
```

```bash
just encrypt /dev/shm/secret.yml
```
