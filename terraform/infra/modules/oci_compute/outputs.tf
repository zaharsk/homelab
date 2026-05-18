output "availability_domains" {
  value = [
    for ad in data.oci_identity_availability_domains.ads.availability_domains :
    ad.name
  ]
}

output "instances" {
  value = {
    for name, instance in oci_core_instance.this :
    name => {
      ip     = instance.public_ip
      groups = var.instances[name].groups
      user   = "ubuntu"
    }
  }
}