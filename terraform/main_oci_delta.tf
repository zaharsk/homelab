module "oci_delta_compartment" {
  source = "./modules/oci_compartment"
  providers = {
    oci = oci.delta
  }
  parent_compartment_id = var.oci_delta_tenancy
}

module "oci_delta_vcn" {
  source = "./modules/oci_vcn"
  providers = {
    oci = oci.delta
  }
  compartment_id = module.oci_delta_compartment.id
}

module "oci_delta_igw" {
  source = "./modules/oci_igw"
  providers = {
    oci = oci.delta
  }
  compartment_id = module.oci_delta_compartment.id
  vcn_id         = module.oci_delta_vcn.id
}

module "oci_delta_rt" {
  source = "./modules/oci_rt"
  providers = {
    oci = oci.delta
  }
  compartment_id    = module.oci_delta_compartment.id
  vcn_id            = module.oci_delta_vcn.id
  network_entity_id = module.oci_delta_igw.id
}

module "oci_delta_subnet" {
  source = "./modules/oci_subnet"
  providers = {
    oci = oci.delta
  }
  compartment_id = module.oci_delta_compartment.id
  vcn_id         = module.oci_delta_vcn.id
  route_table_id = module.oci_delta_rt.id
  security_list_ids = [
    module.oci_delta_vcn.default_security_list_id
  ]
}

module "oci_delta_nsg" {
  source = "./modules/oci_nsg"
  providers = {
    oci = oci.delta
  }

  compartment_id = module.oci_delta_compartment.id
  vcn_id         = module.oci_delta_vcn.id
}

module "oci_delta_compute" {
  source = "./modules/oci_compute"
  providers = {
    oci = oci.delta
  }

  compartment_id      = module.oci_delta_compartment.id
  subnet_id           = module.oci_delta_subnet.id
  available_nsg       = module.oci_delta_nsg.groups
  ssh_public_key_path = var.ssh_public_key_path

  instances = {
    # hotel = {
    #   shape         = "VM.Standard.E2.1.Micro"
    #   ocpus         = 1
    #   memory_in_gbs = 1
    #   enabled_nsg   = ["ssh", "web"]
    #   groups = [
    #     "cloud",
    #     "oci",
    #     "ubuntu",
    #     "x86",
    #     "node"
    #   ]
    # },

    # india = {
    #   shape         = "VM.Standard.E2.1.Micro"
    #   ocpus         = 1
    #   memory_in_gbs = 1
    #   enabled_nsg   = ["ssh"]
    #   groups = [
    #     "cloud",
    #     "oci",
    #     "ubuntu",
    #     "x86",
    #     "node"
    #   ]
    # },

    # juliett = {
    #   shape         = "VM.Standard.A1.Flex"
    #   ocpus         = 2
    #   memory_in_gbs = 12
    #   enabled_nsg   = ["ssh"]
    #   groups = [
    #     "cloud",
    #     "oci",
    #     "ubuntu",
    #     "arm",
    #     "node"
    #   ]
    # },

    # kilo = {
    #   shape         = "VM.Standard.A1.Flex"
    #   ocpus         = 2
    #   memory_in_gbs = 12
    #   enabled_nsg   = ["ssh"]
    #   groups = [
    #     "cloud",
    #     "oci",
    #     "ubuntu",
    #     "arm",
    #     "node"
    #   ]
    # }
  }
}
