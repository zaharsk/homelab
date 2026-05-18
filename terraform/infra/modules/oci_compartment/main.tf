resource "oci_identity_compartment" "this" {
  compartment_id = var.parent_compartment_id

  name          = "homelab"
  description   = "Homelab compartment"
  enable_delete = false
  freeform_tags = {
    managed-by = "opentofu"
    project    = "homelab"
  }
}