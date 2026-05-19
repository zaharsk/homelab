resource "vault_identity_group" "admins" {
  name = "admins"
  policies = [
    vault_policy.admin.id
  ]
}
