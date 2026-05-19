resource "vault_identity_oidc_key" "main" {
  allowed_client_ids = ["*"]
  name               = "main"
}

resource "vault_identity_oidc_provider" "default" {
  name          = "default"
  https_enabled = true

  allowed_client_ids = [
    vault_identity_oidc_client.dockhand.client_id
  ]

  scopes_supported = [
    vault_identity_oidc_scope.profile.name,
    vault_identity_oidc_scope.email.name
  ]
}

## terraform output dockhand
output "dockhand" {
  value = {
    client_id     = vault_identity_oidc_client.dockhand.client_id
    client_secret = vault_identity_oidc_client.dockhand.client_secret
  }
  sensitive = true
}
