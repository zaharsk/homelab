data "google_compute_image" "ubuntu" {
  family  = "ubuntu-minimal-2604-lts-amd64"
  project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "this" {
  for_each = var.instances

  name         = each.key
  machine_type = each.value.machine_type
  zone         = var.gcp_zone

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size  = each.value.boot_disk_size
      type  = "pd-standard"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys = "${each.value.user}:${file(pathexpand(var.ssh_public_key_path))}"
  }
}
