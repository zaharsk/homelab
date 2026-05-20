# Oracle Cloud based virtual Homelab

## Preparation

### 1. Generate keys:

```sh
./scripts/generate-secrets.sh
```

### 2. Encrypt keys

```sh
just secrets-encode
```

---

```bash
code /dev/shm/secret.yml
```

```bash
just encrypt /dev/shm/secret.yml
```
