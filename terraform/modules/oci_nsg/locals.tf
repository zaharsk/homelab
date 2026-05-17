## Protocols:  ICMP ("1"), TCP ("6"), UDP ("17"), and ICMPv6 ("58").

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
        key        = "${group_name}-${rule.port}"
        group_name = group_name
        rule       = rule
      }
    ]
  ])
}