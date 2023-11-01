variable "virtual_networks" {
  type    = map(object({
    name       = string
    address_ip = string
  }))
  default = {}
}



variable "resource_group_location" {
  type = string
  
}
variable "resource_group_name" {
  type = string
  
}

variable "nsg_rules" {
  type = map(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_address_prefix      = string
    source_port_range          = string
    destination_address_prefix = any
    destination_port_range     = any
    network_security_group_name = string
  }))
  default = {}
}
variable "nsgs" {
  type = map(object({
    name = string
  }))
}

