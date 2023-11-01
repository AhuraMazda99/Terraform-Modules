variable "vms" {
  type = map(object({
     name                          = optional(string,"default-vm")
    size                          = optional(string,"Standard_D4s_v3")
    storage_account_type          = optional(string,"Standard_LRS" )
    disk_size_gb                  = optional(number, 250)
    private_ip_address_allocation = optional(string,"Dynamic" )
    publisher                     = optional(string,"MicrosoftWindowsServer" )
    offer                         = optional(string,"WindowsServer" )
    sku                           = optional(string,"2022-datacenter-azure-edition" )
    version                       = optional(string,"latest" )
    admin_username                = optional(string,"adminuser" )
    admin_password                = optional(string,"Password12345!" )
    subnet                        = optional(string,"Application" )
  }))
  }


variable "resource_group_location" {
  type = string

}
variable "resource_group_name" {
  type = string
  
}




