variable "ssh_public_key_path" {
  type = string
}

# --> OCI Zulu
variable "oci_zulu_tenancy" {
  type      = string
  sensitive = true
}
variable "oci_zulu_user" {
  type      = string
  sensitive = true
}
variable "oci_zulu_fingerprint" {
  type      = string
  sensitive = true
}
variable "oci_zulu_private_key_path" {
  type      = string
  sensitive = true
}
variable "oci_zulu_region" {
  type      = string
  sensitive = true
}

# --> OCI Delta
variable "oci_delta_tenancy" {
  type      = string
  sensitive = true
}
variable "oci_delta_user" {
  type      = string
  sensitive = true
}
variable "oci_delta_fingerprint" {
  type      = string
  sensitive = true
}
variable "oci_delta_private_key_path" {
  type      = string
  sensitive = true
}
variable "oci_delta_region" {
  type      = string
  sensitive = true
}

# --> GCP Zulu
# variable "gcp_project" {
#   type      = string
#   sensitive = true
# }
# variable "gcp_private_key_path" {
#   type      = string
#   sensitive = true
# }
# variable "gcp_free_region" {
#   type = string
# }
# variable "gcp_free_zone" {
#   type = string
# }
