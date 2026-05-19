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

## https://vault.unco.games/v1/identity/oidc/provider/default/.well-known/openid-configuration
