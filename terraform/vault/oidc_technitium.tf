resource "vault_identity_oidc_assignment" "technitium" {
  name = "technitium-assignment"
  group_ids = [
    vault_identity_group.list["technitium_admins"].id
  ]
}

resource "vault_identity_oidc_client" "technitium" {
  name = "technitium"
  key  = vault_identity_oidc_key.main.name
  assignments = [
    vault_identity_oidc_assignment.technitium.name
  ]

  redirect_uris = [
    "https://technitium.unco.games/sso/callback"
  ]
}

output "oidc_technitium" {
  value = {
    client_id     = vault_identity_oidc_client.technitium.client_id
    client_secret = vault_identity_oidc_client.technitium.client_secret
  }
  sensitive = true
}
