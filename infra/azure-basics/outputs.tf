# infra/azure-basics/outputs.tf

# This file defines the output values that will be displayed in your terminal
# after 'terraform apply' completes. These outputs provide easy access to
# important resource attributes and connection details.

# --- Resource Group Outputs ---
output "resource_group_name" {
  description = "The name of the created Azure Resource Group."
  value       = azurerm_resource_group.main.name
}

output "resource_group_location" {
  description = "The location of the created Azure Resource Group."
  value       = azurerm_resource_group.main.location
}

# --- Virtual Network Outputs ---
output "virtual_network_name" {
  description = "The name of the created Azure Virtual Network."
  value       = azurerm_virtual_network.main.name
}

output "virtual_network_id" {
  description = "The ID of the created Azure Virtual Network (useful for cross-configuration referencing)."
  value       = azurerm_virtual_network.main.id
}

# --- Virtual Machine & Access Outputs ---
output "public_ip_address" {
  description = "The public IP address of the Linux VM."
  value       = azurerm_public_ip.main.ip_address
}

output "vm_admin_username" {
  description = "The admin username for the Linux VM."
  value       = var.vm_admin_username
}

output "ssh_command" {
  description = "Suggested SSH command to connect to the VM."
  value       = "ssh ${var.vm_admin_username}@${azurerm_public_ip.main.ip_address}"
}

# --- Azure Key Vault Outputs ---
output "key_vault_uri" {
  description = "The URI of the created Azure Key Vault."
  value       = azurerm_key_vault.main.vault_uri
}

output "key_vault_ssh_secret_name" {
  description = "The name of the secret storing the SSH public key in Key Vault."
  value       = azurerm_key_vault_secret.ssh_public_key_secret.name
}
