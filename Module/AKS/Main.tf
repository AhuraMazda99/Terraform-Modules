# Define provider
provider "azurerm" {
    features {}
}


# Define AKS cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
    for_each = var.aks

    name = var.aks[each.key].name
    location = var.resource_group_location
    resource_group_name = var.resource_group_name
    dns_prefix = each.value.dns_prefix
    kubernetes_version = each.value.kubernetes_version
    node_resource_group = each.value.node_resource_group
    default_node_pool {
        name = each.value.default_node_pool_name
        node_count = each.value.default_node_pool_node_count
        vm_size = each.value.default_node_pool_vm_size
    }
    
    
}