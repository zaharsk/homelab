resource "oci_core_vcn" "this" {
  compartment_id = var.compartment_id

  cidr_blocks  = ["10.0.0.0/16"]
  display_name = "homelab-vcn"
  dns_label    = "homelabvcn"
  # is_ipv6enabled = true
  freeform_tags = {
    managed-by = "opentofu"
    project    = "homelab"
  }
}