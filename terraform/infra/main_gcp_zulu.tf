module "gcp_zulu_compute" {
  source = "./modules/gcp_compute"
  providers = {
    google = google.zulu
  }

  ssh_public_key_path = var.ssh_public_key_path
  gcp_zone            = var.gcp_zone
  instances = {
    echo = {
      machine_type   = "e2-micro"
      boot_disk_size = 30
      user           = "ubuntu"
      groups = [
        "cloud",
        "gcp",
        "ubuntu",
        "x86",
        "worker"
      ]
    }
  }
}
