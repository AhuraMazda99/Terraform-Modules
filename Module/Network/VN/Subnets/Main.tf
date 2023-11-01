# subnet/main.tf

resource "azurerm_subnet" "Subnets" {
  for_each = var.subnets

  name                 = var.subnets[each.key].name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.subnets[each.key].network
  address_prefixes     = [var.subnets[each.key].address_ip]
}
