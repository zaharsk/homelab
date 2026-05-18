output "groups" {
  value = {
    for name, group in oci_core_network_security_group.this :
    name => group.id
  }
}