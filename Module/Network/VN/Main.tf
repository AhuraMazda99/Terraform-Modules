
resource "azurerm_virtual_network" "VN" {
  for_each = var.virtual_networks

  name                = each.value.name
  address_space       = [each.value.address_ip]
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  tags = {
    team = "platform"
  }
}

resource "azurerm_network_security_group" "NsG1" {
  for_each = var.nsgs

  name                = var.nsgs[each.key].name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "nsg_rules" {
   for_each = var.nsg_rules

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_address_prefix       = each.value.source_address_prefix
  source_port_range           = each.value.source_port_range
  destination_address_prefix  = each.value.destination_address_prefix
  destination_port_range      = each.value.destination_port_range
  network_security_group_name = each.value.network_security_group_name
  resource_group_name         = var.resource_group_name
}

