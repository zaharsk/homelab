## 0. Login into Vault container

```bash
vault login root_token
```

## 1. Create `admin` policy

```bash
vault policy write admin -<<EOF
path "auth/*" {
    capabilities = ["create", "read", "update", "delete", "list", "patch", "sudo"]
}
path "identity/*" {
    capabilities = ["create", "read", "update", "delete", "list", "patch", "sudo"]
}
path "sys/*" {
    capabilities = ["create", "read", "update", "delete", "list", "patch", "sudo"]
}
EOF
```

## 3. Enable AppRole backend

```sh
vault auth enable approle
```

## 4. Create `terraform` user in approle

```bash
vault write auth/approle/role/terraform \
    policies="default,admin"
```

## 5. Recieve `terraform` role-id

```bash
vault read auth/approle/role/terraform/role-id
```

## 5. Recieve `terraform` secret-id

```bash
vault write -f auth/approle/role/terraform/secret-id
```

---

## Reveal sensitive output

```bash
terraform output OUTPUT_NAME
```

## Change user password

```bash
vault write auth/userpass/users/USERNAME/password password="NEW_SUPER_SECRET_PASSWORD"
```
