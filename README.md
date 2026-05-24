# Oracle Cloud based virtual Homelab

## Preparation

### 1. Generate keys:

```sh
./scripts/generate-secrets.sh
```

### 2. Terraform init

```sh
terraform init -upgrade -reconfigure -backend-config=s3.tfbackend.json
```

### 3. Create secrets

```sh
code /dev/shm/secret.yml
```

```sh
just encrypt /dev/shm/secret.yml
```

### 4. Lint compose.yaml

```sh
docker run -t --rm -v ${PWD}:/app zavoloklom/dclint . --fix
```

### 5. Check security

```sh
docker run -t -v "${PWD}":/path checkmarx/kics scan -p /path -o "/path/"
```
