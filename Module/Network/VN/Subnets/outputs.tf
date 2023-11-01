output "subnet_names" {
  value = { for k, v in var.subnets : k => v.name }
}
output "subnet_objects" {
  value = {
    for k, v in var.subnets :
    k => azurerm_subnet.Subnets[k]
  }
}
