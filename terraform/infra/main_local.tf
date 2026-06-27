module "local_inventory" {
  source = "./modules/local_inventory"

  hosts = {
    zulu = {
      ip   = "192.168.0.101"
      user = "ubuntu"

      groups = [
        "local",
        "home",
        "ubuntu",
        "x86",
        "worker"
      ]
    },

    yankee = {
      ip   = "192.168.0.102"
      user = "ubuntu"

      groups = [
        "local",
        "home",
        "ubuntu",
        "x86",
        "worker",
        "runners"
      ]
    },

    xuiru = {
      ip   = "178.20.46.128"
      user = "ubuntu"

      groups = [
        "cloud",
        "vdsina",
        "ubuntu",
        "x86",
        "worker"
      ]
    }

  }
}
