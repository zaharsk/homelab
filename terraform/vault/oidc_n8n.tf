resource "vault_identity_oidc_assignment" "n8n" {
  name = "n8n-assignment"
  group_ids = [
    vault_identity_group.list["n8n-users"].id
  ]
}

resource "vault_identity_oidc_client" "n8n" {
  name = "n8n"
  key  = vault_identity_oidc_key.main.name
  assignments = [
    vault_identity_oidc_assignment.n8n.name
  ]

  redirect_uris = [
    "https://n8n.unco.games/auth/oidc/callback"
  ]
}

output "oidc-n8n" {
  value = {
    client_id     = vault_identity_oidc_client.n8n.client_id
    client_secret = vault_identity_oidc_client.n8n.client_secret
  }
  sensitive = true
}
