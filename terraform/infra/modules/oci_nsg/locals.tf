locals {
  protocols = {
    "1"  = "icmp"
    "6"  = "tcp"
    "17" = "udp"
    "58" = "icmp_v6"
  }
}

locals {
  groups = {
    ssh = {
      ingress = [
        {
          protocol    = "6"
          source_type = "CIDR_BLOCK"
          source      = "0.0.0.0/0"
          port        = 22
        }
      ]
    }

    web = {
      ingress = [
        {
          protocol    = "6"
          source_type = "CIDR_BLOCK"
          source      = "0.0.0.0/0"
          port        = 80
        },
        {
          protocol    = "6"
          source_type = "CIDR_BLOCK"
          source      = "0.0.0.0/0"
          port        = 443
        }
      ]
    }
  }

  ingress_rules = flatten([
    for group_name, group in local.groups : [
      for rule in group.ingress : {
        key        = "${group_name}-${local.protocols[rule.protocol]}-${rule.port}"
        group_name = group_name
        rule       = rule
      }
    ]
  ])
}
