output "instances" {
  value = {
    for name, instance in google_compute_instance.this :
    name => {
      ip     = instance.network_interface[0].access_config[0].nat_ip
      groups = var.instances[name].groups
      user   = var.instances[name].user
    }
  }
}
