resource "vault_generic_endpoint" "userpass_users" {
  depends_on   = [vault_auth_backend.userpass]
  for_each     = var.users
  path         = "auth/${vault_auth_backend.userpass.path}/users/${each.key}"
  disable_read = true
  data_json = jsonencode({
    policies = each.value.policies
    password = each.value.password
  })
}

resource "vault_identity_entity" "users" {
  for_each = var.users
  name     = each.key
  metadata = {
    email = each.value.email
  }
}

resource "vault_identity_entity_alias" "userpass_aliases" {
  for_each       = var.users
  name           = each.key
  mount_accessor = vault_auth_backend.userpass.accessor
  canonical_id   = vault_identity_entity.users[each.key].id
}
