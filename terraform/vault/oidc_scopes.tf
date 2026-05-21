resource "vault_identity_oidc_scope" "profile" {
  name     = "profile"
  template = <<EOT
{
  "name": {{identity.entity.metadata.display_name}},
  "display_name": {{identity.entity.metadata.display_name}},
  "login": {{identity.entity.metadata.username}},
  "username": {{identity.entity.metadata.username}},
  "preferred_username": {{identity.entity.metadata.username}},
  "email": {{identity.entity.metadata.email}},
  "email_verified": true
}
EOT
}

resource "vault_identity_oidc_scope" "email" {
  name     = "email"
  template = <<EOT
{
  "email": {{identity.entity.metadata.email}}
}
EOT
}

resource "vault_identity_oidc_scope" "groups" {
  name = "groups"

  template = <<EOT
{
  "groups": {{identity.entity.groups.names}}
}
EOT
}
