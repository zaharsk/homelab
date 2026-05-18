output "inventory" {
  value = {
    servers = merge(
      module.oci_zulu_compute.instances,
      module.oci_delta_compute.instances,
      module.gcp_zulu_compute.instances,
      module.local_inventory.instances,
    )
  }
}
