terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "5.9.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.9.0"
    }
  }
}
