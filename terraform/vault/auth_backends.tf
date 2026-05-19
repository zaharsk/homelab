resource "vault_auth_backend" "approle" {
  type = "approle"
  path = "approle"
}

resource "vault_auth_backend" "userpass" {
  type = "userpass"
  path = "userpass"
}
