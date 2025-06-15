# Variable for the resource group name prefix
variable "resource_group_name_prefix" {
  description = "A prefix for the resource group name (e.g., 'dev-rg', 'prod-rg')"
  type        = string
}

# Variable for the Azure region where the resource group will be created
variable "resource_group_location" {
  description = "The Azure region for the resource group (e.g., 'East US', 'West Europe')"
  type        = string
}

# Variable for the environment tag
variable "environment_tag" {
  description = "The environment tag for the resource group (e.g., 'Development', 'Production')"
  type        = string
}

# New: Variable for Virtual Network name prefix
variable "vnet_name_prefix" {
  description = "A prefix for the Virtual Network name"
  type        = string
  default     = "vnet" # Provide a default for convenience
}

# New: Variable for Virtual Network address space (CIDR block)
variable "vnet_address_space" {
  description = "The address space for the Virtual Network (e.g., '10.0.0.0/16')"
  type        = string
}

# New: Variable for Subnet name prefix
variable "subnet_name_prefix" {
  description = "A prefix for the Subnet name"
  type        = string
  default     = "subnet" # Provide a default for convenience
}

# New: Variable for Subnet address prefix (CIDR block)
variable "subnet_address_prefix" {
  description = "The address prefix for the Subnet (e.g., '10.0.1.0/24')"
  type        = string
}
