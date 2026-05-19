variable "vault_address" {
  type      = string
  sensitive = true
}

variable "terraform_role_id" {
  type = string
}

variable "terraform_secret_id" {
  type      = string
  sensitive = true
}
