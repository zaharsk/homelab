resource "oci_core_internet_gateway" "this" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  enabled        = true
  display_name   = "homelab-igw"
  freeform_tags = {
    managed-by = "opentofu"
    project    = "homelab"
  }
}