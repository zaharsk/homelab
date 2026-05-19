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
