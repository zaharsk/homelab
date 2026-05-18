resource "oci_core_subnet" "this" {
  compartment_id    = var.compartment_id
  vcn_id            = var.vcn_id
  cidr_block        = "10.0.1.0/24"
  display_name      = "homelab-subnet"
  dns_label         = "homelabsubnet"
  route_table_id    = var.route_table_id
  security_list_ids = var.security_list_ids
  freeform_tags = {
    managed-by = "opentofu"
    project    = "homelab"
  }
}