# path "pki/*" {
#     capabilities = ["create", "read", "update", "delete", "list", "patch", "sudo"]
# }
# path "kv/*" {
#   capabilities = ["create", "read", "update", "delete", "list", "patch", "sudo"]
# }

resource "vault_policy" "list" {
  for_each = local.policies_list
  name     = each.key
  policy   = each.value
}

locals {
  policies_list = {
    admin = <<EOT
path "auth/*" {
    capabilities = ["create", "read", "update", "delete", "list", "patch", "sudo"]
}
path "identity/*" {
    capabilities = ["create", "read", "update", "delete", "list", "patch", "sudo"]
}
path "sys/*" {
    capabilities = ["create", "read", "update", "delete", "list", "patch", "sudo"]
}
EOT
  }
}
