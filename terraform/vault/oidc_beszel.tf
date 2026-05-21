resource "vault_identity_oidc_assignment" "beszel" {
  name = "beszel-assignment"
  group_ids = [
    vault_identity_group.list["beszel_admins"].id
  ]
}

resource "vault_identity_oidc_client" "beszel" {
  name = "beszel"
  key  = vault_identity_oidc_key.main.name
  assignments = [
    vault_identity_oidc_assignment.beszel.name
  ]

  redirect_uris = [
    "https://beszel.unco.games/api/oauth2-redirect"
  ]
}

output "beszel" {
  value = {
    client_id     = vault_identity_oidc_client.beszel.client_id
    client_secret = vault_identity_oidc_client.beszel.client_secret
  }
  sensitive = true
}
