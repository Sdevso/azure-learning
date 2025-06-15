# Output the name of the created resource group
output "resource_group_name" {
  value       = azurerm_resource_group.main.name
  description = "The name of the created Azure Resource Group"
}

# Output the location of the created resource group
output "resource_group_location" {
  value       = azurerm_resource_group.main.location
  description = "The location of the created Azure Resource Group"
}

# Output the name of the created Virtual Network
output "virtual_network_name" {
  value       = azurerm_virtual_network.main.name
  description = "The name of the created Azure Virtual Network"
}

# Output the ID of the created Virtual Network (useful for cross-configuration referencing)
output "virtual_network_id" {
  value       = azurerm_virtual_network.main.id
  description = "The ID of the created Azure Virtual Network"
}
