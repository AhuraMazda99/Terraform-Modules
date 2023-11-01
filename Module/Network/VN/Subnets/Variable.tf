
variable "subnets" {
  type = map(object({
    name      = string
    address_ip = string
    network    = string
  }))
  default = {}
}

variable "resource_group_name" {
  type = string
}