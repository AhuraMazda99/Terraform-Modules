provider "azurerm" {
    features {}
}
terraform {
  backend "azurerm" {
    storage_account_name = "terraformtestnthub"
    container_name       = "terraformstate"
    key                  = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "VN" {
  name = "VN_RG"
  location = "westeurope"
}

resource "azurerm_resource_group" "VM" {
  name = "VM_RG"
  location = "westeurope"
}


module "VN" {
  source = "./Module/Network/VN"
  resource_group_name = azurerm_resource_group.VN.name
  resource_group_location = azurerm_resource_group.VN.location
  virtual_networks = {
    network1 = {
      name       = "NTWENetwork"
      address_ip = "10.31.20.0/23"
    },
    network2 = {
      name       = "NTWE-HUBTRANSIT"
      address_ip = "10.10.0.0/22"
    },
    network3 = {
      name       = "NTESubMultiTier"
      address_ip = "10.32.0.0/16"
    },
    # Add more virtual networks as needed
  }
  nsgs = {
    network_security_group1 ={
    name = "NTStandardNSG"
  }
  }

  nsg_rules = {
    NSG_Rules1 = {
      name                        = "NT_Offices_Outbound_All"
      priority                    = 1077
      direction                   = "Outbound"
      access                      = "Deny"
      protocol                    = "*"
      source_port_range           = "*"
      destination_port_range      = "*"
      source_address_prefix       = "*"
      destination_address_prefix  = "VirtualNetwork"
      network_security_group_name = module.VN.nsg_names["network_security_group1"]
    }
}
}

module "Subnets" {
  source = "./Module/Network/VN/Subnets"
  resource_group_name = azurerm_resource_group.VN.name
  subnets = {
    subnet1 = {
      name       = "GatewaySubnet"
      address_ip = "10.31.20.0/28"
      network = module.VN.virtual_network_names["network1"]
    },
  subnet2 = {
      name       = "Test"
      address_ip = "10.31.20.32/27"
      network = module.VN.virtual_network_names["network1"]
    },
    subnet3 = {
      name       = "AppGW"
      address_ip = "10.31.21.32/28"
      network = module.VN.virtual_network_names["network1"]
    },
    subnet4 = {
      name       = "AppGW_II"
      address_ip = "10.31.21.48/28"
      network = module.VN.virtual_network_names["network1"]
    },
    subnet5 = {
      name       = "client"
      address_ip = "10.31.21.16/28"
      network = module.VN.virtual_network_names["network1"]
    },
    subnet6 = {
      name       = "Development"
      address_ip = "10.31.20.64/26"
      network = module.VN.virtual_network_names["network1"]
    },
    subnet7 = {
      name       = "infrastrucutre"
      address_ip = "10.31.20.16/28"
      network = module.VN.virtual_network_names["network1"]
    },
    subnet8 = {
      name       = "Application"
      address_ip = "10.31.20.128/25"
      network = module.VN.virtual_network_names["network1"]
    },
    subnet9 = {
      name       = "DMZ_ForceRouting"
      address_ip = "10.31.21.64/28"
      network = module.VN.virtual_network_names["network1"]
    },
    subnet10 = {
      name       = "DMZ"
      address_ip = "10.31.21.0/28"
      network = module.VN.virtual_network_names["network1"]
    },
    subnet11 = {
      name       = "GatewaySubnet"
      address_ip = "10.10.0.0/28"
      network = module.VN.virtual_network_names["network2"]
    },
    subnet12 = {
      name       = "AzureFirewallSubnet"
      address_ip = "10.10.2.0/24"
      network = module.VN.virtual_network_names["network2"]
    },
    subnet13 = {
      name       = "NTWE-Appgw-Subnet"
      address_ip = "10.10.3.0/24"
      network = module.VN.virtual_network_names["network2"]
    },
    subnet14 = {
      name       = "Test2"
      address_ip = "10.10.0.64/26"
      network = module.VN.virtual_network_names["network2"]
    },
    subnet15 = {
      name       = "GatewaySubnet"
      address_ip = "10.32.20.0/28"
      network = module.VN.virtual_network_names["network3"]
    },
    subnet16 = {
      name       = "NTEDMZ"
      address_ip = "10.32.4.0/24"
      network = module.VN.virtual_network_names["network3"]
    },

         # Add more Subnets as needed
  }
}

module "VM" {
  source = "./Module/VM"
  # Provide values for variables defined in your VM module
  resource_group_name   = azurerm_resource_group.VM.name
  resource_group_location = azurerm_resource_group.VM.location

  vms = {
    vm1 = {
      name           = "hvlovn3"
      subnet         = module.Subnets.subnet_objects["subnet8"].id
    },
  
}
}

