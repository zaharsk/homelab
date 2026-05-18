variable "ssh_public_key_path" {
  type = string
}

variable "gcp_zone" {
  type = string
}

variable "instances" {
  type = map(object({
    machine_type   = string
    boot_disk_size = number
    user           = string
    groups         = list(string)
  }))

  # Allowed machine type
  validation {
    condition = alltrue([
      for instance in values(var.instances) :
      contains([
        "e2-micro",
      ], instance.machine_type)
    ])
    error_message = "Allowed types: e2-micro"
  }

  # e2-micro restrictions
  validation {
    condition = alltrue([
      for instance in values(var.instances) :

      (instance.shape != "e2-micro") ||
      (
        instance.boot_disk_size <= 30
      )
    ])
    error_message = "e2-micro must use less 30Gb disk for free."
  }
}

