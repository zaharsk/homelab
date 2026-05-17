output "inventory" {
  value = {
    servers = merge(
      module.zulu_compute.instances,
      module.delta_compute.instances,
      module.gcp_compute.instances,
      module.local_inventory.instances,
    )
  }
}
