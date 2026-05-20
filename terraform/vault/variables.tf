variable "vault_address" {
  type = string
}

variable "terraform_role_id" {
  sensitive = true
  type      = string
}

variable "terraform_secret_id" {
  sensitive = true
  type      = string
}

variable "groups" {
  type = map(object({
    policies = list(string)
    members  = list(string)
  }))
}

variable "users" {
  type = map(object({
    email              = string
    name               = string
    preferred_username = string
  }))
}
