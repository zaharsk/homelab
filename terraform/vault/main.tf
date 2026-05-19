terraform {
  backend "s3" {
    key                         = "vault.tfstate"
    region                      = "auto"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true
  }
}

resource "vault_generic_endpoint" "client_count_tracking" {
  path = "sys/internal/counters/config"

  data_json = jsonencode({
    enabled = "enable"
  })
}
