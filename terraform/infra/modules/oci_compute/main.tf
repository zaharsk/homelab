data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

data "oci_core_images" "ubuntu" {
  for_each                 = var.instances
  compartment_id           = var.compartment_id
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "24.04"
  shape                    = each.value.shape
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

resource "oci_core_instance" "this" {
  for_each            = var.instances
  availability_domain = local.last_ad
  compartment_id      = var.compartment_id

  agent_config {
    are_all_plugins_disabled = true
    is_management_disabled   = true
    is_monitoring_disabled   = true
  }

  create_vnic_details {
    # assign_ipv6ip    = true
    assign_public_ip = true
    display_name     = each.key
    hostname_label   = each.key
    subnet_id        = var.subnet_id
    nsg_ids = [
      for name in each.value.enabled_nsg :
      var.available_nsg[name]
    ]
  }

  display_name = each.key
  metadata = {
    ssh_authorized_keys = file(pathexpand(var.ssh_public_key_path))
  }

  shape = each.value.shape
  shape_config {
    ocpus         = each.value.ocpus
    memory_in_gbs = each.value.memory_in_gbs
  }

  source_details {
    source_id   = data.oci_core_images.ubuntu[each.key].images[0].id
    source_type = "image"
  }

  freeform_tags = {
    managed-by = "opentofu"
    project    = "homelab"
    groups     = jsonencode(each.value.groups)
  }
}