# Configure the Azure Resource Manager Provider
provider "azurerm" {
  features {}
}

# Configure Terraform to use Azure Blob Storage for remote state
terraform {
  backend "azurerm" {
    storage_account_name = "tfstatesushiltstaz123" # ENSURE THIS IS YOUR ACTUAL, CORRECT NAME
    container_name       = "tfstate"
    resource_group_name  = "tfstate-rg"
  }
}

# Resource to generate a random ID
resource "random_id" "resource_group_suffix" {
  byte_length = 4
}

# Declare an Azure Resource Group resource
# This resource creates or manages your Resource Group based on variable inputs.
resource "azurerm_resource_group" "main" {
  name     = "${var.resource_group_name_prefix}-${random_id.resource_group_suffix.hex}"
  location = var.resource_group_location

  tags = {
    Environment = var.environment_tag
    ManagedBy   = "Terraform"
  }
}

# Data Source: Retrieve information about an existing Azure Resource Group
# This data block reads the properties of the resource group created above.
# It allows us to reference its ID, name, or location without hardcoding them.
data "azurerm_resource_group" "existing_rg" {
  name = azurerm_resource_group.main.name
}

# Declare an Azure Virtual Network (VNet) resource
# This VNet will be created within the Resource Group defined above.
resource "azurerm_virtual_network" "main" {
  name                = "${var.vnet_name_prefix}-${random_id.resource_group_suffix.hex}"
  address_space       = [var.vnet_address_space]                         # Takes a list of CIDR blocks
  location            = data.azurerm_resource_group.existing_rg.location # Use location from data source
  resource_group_name = data.azurerm_resource_group.existing_rg.name     # Use name from data source

  tags = {
    Environment = var.environment_tag
    ManagedBy   = "Terraform"
  }
}

# Declare an Azure Subnet resource
# This subnet will be created within the Virtual Network defined above.
resource "azurerm_subnet" "main" {
  name                 = "${var.subnet_name_prefix}-${random_id.resource_group_suffix.hex}"
  resource_group_name  = data.azurerm_resource_group.existing_rg.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.subnet_address_prefix] # Takes a list of CIDR blocks

  # Optional: Link to a Network Security Group or Route Table if needed later
}

