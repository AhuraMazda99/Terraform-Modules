# vm_module/main.tf
resource "azurerm_virtual_machine" "vm" {
  for_each = var.vms

  name                  = each.value.name
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  vm_size = each.value.size

  storage_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
    
  }

  os_profile   {
    computer_name  = each.value.name
    admin_username = each.value.admin_username
    admin_password = each.value.admin_password
  }
  os_profile_windows_config {
    provision_vm_agent = true
  }

  storage_os_disk {
    name             = "${each.value.name}-osdisk"
    caching          = "ReadWrite"
    create_option    = "FromImage"
    managed_disk_type = each.value.storage_account_type
    disk_size_gb = each.value.disk_size_gb

    
  }
  
  


}

resource "azurerm_network_interface" "nic" {
  for_each = var.vms

  name                = "${each.value.name}-nic"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${each.value.name}-ipconfig"
    subnet_id                     = each.value.subnet
    private_ip_address_allocation = each.value.private_ip_address_allocation
  
}
}