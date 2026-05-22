resource "vault_identity_oidc_key" "main" {
  allowed_client_ids = ["*"]
  name               = "main"
}

resource "vault_identity_oidc_provider" "default" {
  name          = "default"
  https_enabled = true

  allowed_client_ids = [
    vault_identity_oidc_client.dockhand.client_id,
    vault_identity_oidc_client.grafana.client_id,
    vault_identity_oidc_client.beszel.client_id,
    vault_identity_oidc_client.technitium.client_id
  ]

  scopes_supported = [
    vault_identity_oidc_scope.profile.name,
    vault_identity_oidc_scope.email.name,
    vault_identity_oidc_scope.groups.name
  ]
}

output "oidc_provider" {
  value = {
    issuer = vault_identity_oidc_provider.default.issuer
    info   = "${vault_identity_oidc_provider.default.issuer}/.well-known/openid-configuration"
  }
}
