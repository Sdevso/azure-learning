provider "azurerm" {        
  features {
  }
}

resource "random_id" "rg_suffix" {
  byte_length = 4 # Generates a random 8-character hexadecimal string (4 bytes * 2 hex chars/byte)
}

resource "azurerm_resource_group" "Test-azure1" {
    name = "my-terraform-resource-group-${random_id.rg_suffix.hex}"
    location="East US"
  
}

output "resource_group_name"{
    value = azurerm_resource_group.Test-azure1
    description = "The name if the created azure resource group"
}