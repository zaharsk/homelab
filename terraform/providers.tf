provider "oci" {
  alias            = "zulu"
  tenancy_ocid     = var.oci_zulu_tenancy
  user_ocid        = var.oci_zulu_user
  fingerprint      = var.oci_zulu_fingerprint
  private_key_path = var.oci_zulu_private_key_path
  region           = var.oci_zulu_region
}

provider "oci" {
  alias            = "delta"
  tenancy_ocid     = var.oci_delta_tenancy
  user_ocid        = var.oci_delta_user
  fingerprint      = var.oci_delta_fingerprint
  private_key_path = var.oci_delta_private_key_path
  region           = var.oci_delta_region
}

# provider "google" {
#   alias       = "gcp_free"
#   credentials = var.gcp_private_key_path
#   project     = var.gcp_project
#   region      = var.gcp_free_region
#   zone        = var.gcp_free_zone
# }
