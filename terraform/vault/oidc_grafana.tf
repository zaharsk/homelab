resource "vault_identity_oidc_assignment" "grafana" {
  name = "grafana-assignment"
  group_ids = [
    vault_identity_group.list["grafana_admins"].id
  ]
}

resource "vault_identity_oidc_client" "grafana" {
  name = "grafana"
  key  = vault_identity_oidc_key.main.name
  assignments = [
    vault_identity_oidc_assignment.grafana.name
  ]

  redirect_uris = [
    "https://grafana.unco.games/login/generic_oauth"
  ]
}

output "oidc_grafana" {
  value = {
    client_id     = vault_identity_oidc_client.grafana.client_id
    client_secret = vault_identity_oidc_client.grafana.client_secret
  }
  sensitive = true
}
