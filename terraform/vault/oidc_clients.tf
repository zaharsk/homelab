resource "vault_identity_oidc_assignment" "dockhand" {
  name = "dockhand-assignment"
  group_ids = [
    vault_identity_group.list["dockhand_admins"].id
  ]
}

resource "vault_identity_oidc_client" "dockhand" {
  name = "dockhand"
  key  = vault_identity_oidc_key.main.name
  assignments = [
    vault_identity_oidc_assignment.dockhand.name
  ]

  redirect_uris = [
    "https://dockhand.unco.games/api/auth/oidc/callback"
  ]
}
