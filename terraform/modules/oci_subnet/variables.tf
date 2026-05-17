variable "compartment_id" {
  type      = string
  sensitive = true
}

variable "vcn_id" {
  type      = string
  sensitive = true
}

variable "route_table_id" {
  type      = string
  sensitive = true
}

variable "security_list_ids" {
  type      = list(string)
  sensitive = true
}