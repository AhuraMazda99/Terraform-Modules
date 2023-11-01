output "virtual_network_names" {
  value = { for k, v in azurerm_virtual_network.VN : k => v.name }
}

output "nsg_names" {
  value = { for k, v in azurerm_network_security_group.NsG1 : k => v.name }
}
