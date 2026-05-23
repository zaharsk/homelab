module "oci_zulu_compartment" {
  source = "./modules/oci_compartment"
  providers = {
    oci = oci.zulu
  }
  parent_compartment_id = var.oci_zulu_tenancy
}

module "oci_zulu_vcn" {
  source = "./modules/oci_vcn"
  providers = {
    oci = oci.zulu
  }
  compartment_id = module.oci_zulu_compartment.id
}

module "oci_zulu_igw" {
  source = "./modules/oci_igw"
  providers = {
    oci = oci.zulu
  }
  compartment_id = module.oci_zulu_compartment.id
  vcn_id         = module.oci_zulu_vcn.id
}

module "oci_zulu_rt" {
  source = "./modules/oci_rt"
  providers = {
    oci = oci.zulu
  }
  compartment_id    = module.oci_zulu_compartment.id
  vcn_id            = module.oci_zulu_vcn.id
  network_entity_id = module.oci_zulu_igw.id
}

module "oci_zulu_subnet" {
  source = "./modules/oci_subnet"
  providers = {
    oci = oci.zulu
  }
  compartment_id = module.oci_zulu_compartment.id
  vcn_id         = module.oci_zulu_vcn.id
  route_table_id = module.oci_zulu_rt.id
  security_list_ids = [
    module.oci_zulu_vcn.default_security_list_id
  ]
}

module "oci_zulu_nsg" {
  source = "./modules/oci_nsg"
  providers = {
    oci = oci.zulu
  }

  compartment_id = module.oci_zulu_compartment.id
  vcn_id         = module.oci_zulu_vcn.id
}

module "oci_zulu_compute" {
  source = "./modules/oci_compute"
  providers = {
    oci = oci.zulu
  }

  compartment_id      = module.oci_zulu_compartment.id
  subnet_id           = module.oci_zulu_subnet.id
  available_nsg       = module.oci_zulu_nsg.groups
  ssh_public_key_path = var.ssh_public_key_path

  instances = {
    alpha = {
      shape         = "VM.Standard.A1.Flex"
      ocpus         = 1
      memory_in_gbs = 2
      enabled_nsg = [
        "ssh",
        "web",
        "ssh-forgejo"
      ]
      groups = [
        "cloud",
        "oci",
        "ubuntu",
        "arm",
        "master"
      ]
    },
    bravo = {
      shape         = "VM.Standard.A1.Flex"
      ocpus         = 1
      memory_in_gbs = 2
      enabled_nsg = [
        "ssh",
      ]
      groups = [
        "cloud",
        "oci",
        "ubuntu",
        "arm",
        "worker"
      ]
    }
  }
}
