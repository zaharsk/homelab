data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2404-lts-amd64"
  project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "this" {
  for_each = var.instances

  name         = each.name
  machine_type = each.machine_type
  zone         = var.gcp_zone

  tags = [
    "ssh",
    # "web"
  ]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size  = each.boot_disk_size
      type  = "pd-balanced"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys = "${each.user}:${file(pathexpand(var.ssh_public_key_path))}"
  }
}
