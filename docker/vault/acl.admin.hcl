path "auth/*" {
    capabilities = ["create", "read", "update", "delete", "list", "patch", "sudo"]
}
path "identity/*" {
    capabilities = ["create", "read", "update", "delete", "list", "patch", "sudo"]
}
path "sys/*" {
    capabilities = ["create", "read", "update", "delete", "list", "patch", "sudo"]
}
path "pki/*" {
    capabilities = ["create", "read", "update", "delete", "list", "patch", "sudo"]
}
path "kv/*" {
  capabilities = ["create", "read", "update", "delete", "list", "patch", "sudo"]
}