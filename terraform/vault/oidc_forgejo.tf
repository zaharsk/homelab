resource "vault_identity_oidc_assignment" "forgejo" {
  name = "forgejo-assignment"
  group_ids = [
    vault_identity_group.list["forgejo_admins"].id
  ]
}

resource "vault_identity_oidc_client" "forgejo" {
  name = "forgejo"
  key  = vault_identity_oidc_key.main.name
  assignments = [
    vault_identity_oidc_assignment.forgejo.name
  ]

  redirect_uris = [
    "https://forgejo.unco.games/user/oauth2/vault/callback"
  ]
}

output "oidc_forgejo" {
  value = {
    client_id     = vault_identity_oidc_client.forgejo.client_id
    client_secret = vault_identity_oidc_client.forgejo.client_secret
  }
  sensitive = true
}
