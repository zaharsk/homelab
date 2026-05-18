variable "compartment_id" {
  type      = string
  sensitive = true
}

variable "subnet_id" {
  type = string
}

variable "available_nsg" {
  type = map(string)
}

variable "ssh_public_key_path" {
  type = string
}

variable "instances" {
  type = map(object({
    shape         = string
    ocpus         = number
    memory_in_gbs = number
    enabled_nsg   = list(string)
    groups        = list(string)
  }))

  # Allowed shapes
  validation {
    condition = alltrue([
      for instance in values(var.instances) :
      contains([
        "VM.Standard.E2.1.Micro",
        "VM.Standard.A1.Flex"
      ], instance.shape)
    ])
    error_message = "Allowed shapes: VM.Standard.E2.1.Micro, VM.Standard.A1.Flex."
  }

  # VM.Standard.E2.1.Micro restrictions
  validation {
    condition = alltrue([
      for instance in values(var.instances) :

      (instance.shape != "VM.Standard.E2.1.Micro") ||
      (
        instance.ocpus == 1
        &&
        instance.memory_in_gbs == 1
      )
    ])
    error_message = "VM.Standard.E2.1.Micro must use exactly 1 OCPU and 1 GB RAM."
  }

  # VM.Standard.A1.Flex restrictions
  validation {
    condition = alltrue([
      for instance in values(var.instances) :
      (instance.shape != "VM.Standard.A1.Flex") ||
      (
        instance.ocpus >= 1
        &&
        instance.ocpus <= 4
        &&
        instance.memory_in_gbs >= 1
        &&
        instance.memory_in_gbs <= 24
      )
    ])
    error_message = "VM.Standard.A1.Flex supports 1-4 OCPUs and 1-24 GB RAM."
  }

  # NSG validation
  validation {
    condition = alltrue(flatten([
      for instance in values(var.instances) : [
        for nsg in instance.enabled_nsg :
        contains(keys(var.available_nsg), nsg)
      ]
    ]))
    error_message = "Unknown NSG specified."
  }
}