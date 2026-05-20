resource "random_password" "passwords" {
  for_each = var.users

  length      = 16
  lower       = true
  upper       = true
  numeric     = true
  special     = true
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
}

resource "vault_generic_endpoint" "userpass_users" {
  depends_on = [vault_auth_backend.userpass]
  for_each   = var.users

  path         = "auth/${vault_auth_backend.userpass.path}/users/${each.key}"
  disable_read = true
  data_json = jsonencode({
    password = random_password.passwords[each.key].result
  })
}

resource "vault_identity_entity" "users" {
  for_each = var.users

  name = each.key
  metadata = {
    email        = each.value.email
    display_name = each.value.display_name
    username     = each.value.username
  }
}

resource "vault_identity_entity_alias" "userpass_aliases" {
  for_each = var.users

  name           = each.key
  mount_accessor = vault_auth_backend.userpass.accessor
  canonical_id   = vault_identity_entity.users[each.key].id
}

output "users" {
  sensitive = true

  value = {
    for username, password in random_password.passwords :
    username => password.result
  }
}
