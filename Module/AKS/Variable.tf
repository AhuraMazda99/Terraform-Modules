variable "aks" {
  type    = map(object({
    name       = string
    dns_prefix = string
    kubernetes_version = string
    node_resource_group = string
    default_node_pool_name = string
    default_node_pool_node_count = number
    default_node_pool_vm_size = string
    
  }))
  default = {}
}

variable "resource_group_location" {
  type = string
  
}

variable "resource_group_name" {
  type = string
  
}