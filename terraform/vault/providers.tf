provider "vault" {
  address = var.vault_address
  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id   = var.terraform_role_id
      secret_id = var.terraform_secret_id
    }
  }
}
