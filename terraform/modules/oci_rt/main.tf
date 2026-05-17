resource "oci_core_route_table" "this" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "homelab-public-rt"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = var.network_entity_id ## OCI IGW ID
  }
  freeform_tags = {
    managed-by = "opentofu"
    project    = "homelab"
  }
}