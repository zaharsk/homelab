resource "vault_identity_oidc_scope" "profile" {
  name     = "profile"
  template = <<EOT
{
  "name": {{identity.entity.metadata.name}},
  "preferred_username": {{identity.entity.metadata.preferred_username}}
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
