resource "oci_core_network_security_group" "this" {
  for_each = local.groups

  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id

  display_name = each.key
  freeform_tags = {
    managed-by = "opentofu"
    project    = "homelab"
  }
}

resource "oci_core_network_security_group_security_rule" "ingress" {
  for_each = {
    for rule in local.ingress_rules :
    rule.key => rule
  }

  network_security_group_id = oci_core_network_security_group.this[
    each.value.group_name
  ].id

  direction = "INGRESS"

  protocol = each.value.rule.protocol

  source      = each.value.rule.source
  source_type = each.value.rule.source_type

  dynamic "tcp_options" {
    for_each = each.value.rule.protocol == "6" ? [1] : []
    content {
      destination_port_range {
        min = each.value.rule.port
        max = each.value.rule.port
      }
    }
  }

  dynamic "udp_options" {
    for_each = each.value.rule.protocol == "17" ? [1] : []
    content {
      destination_port_range {
        min = each.value.rule.port
        max = each.value.rule.port
      }
    }
  }
}