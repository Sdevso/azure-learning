# infra/azure-basics/variables.tf

# This file is dedicated solely to declaring input variables for your Terraform configuration.
# Resource blocks, data sources, and provider configurations should be defined in other .tf files (e.g., main.tf).

# --- Resource Group Configuration Variables ---
variable "resource_group_name_prefix" {
  description = "A prefix for the resource group name (e.g., 'dev-rg', 'prod-rg')"
  type        = string
  default     = "my-terraform-rg"
}

variable "location" {
  description = "The Azure region to deploy resources (e.g., 'East US', 'West Europe')."
  type        = string
  default     = "East US"
}

variable "environment_tag" {
  description = "The environment tag for the resources (e.g., 'Development', 'Production')"
  type        = string
  default     = "development"
}

# --- Virtual Network Configuration Variables ---
variable "vnet_name_prefix" {
  description = "A prefix for the Virtual Network name"
  type        = string
  default     = "vnet"
}

variable "vnet_address_space" {
  description = "The address space for the Virtual Network (e.g., '10.0.0.0/16')"
  type        = string
  default     = "10.0.0.0/16"
}

# --- Subnet Configuration Variables ---
variable "subnet_name_prefix" {
  description = "A prefix for the Subnet name"
  type        = string
  default     = "subnet"
}

variable "subnet_address_prefix" {
  description = "The address prefix for the Subnet (e.g., '10.0.1.0/24')"
  type        = string
  default     = "10.0.1.0/24"
}

# --- Virtual Machine Configuration Variables ---
variable "vm_name" {
  description = "The name of the Linux Virtual Machine."
  type        = string
  default     = "my-ubuntu-vm"
}

variable "vm_size" {
  description = "The size of the VM, use free tier for testing 'Standard_B1s'"
  type        = string
  default     = "Standard_B1s"
}

# VM Image details (Ubuntu 20.04 LTS)
variable "vm_image_publisher" {
  description = "The publisher of the VM image."
  type        = string
  default     = "Canonical"
}

variable "vm_image_offer" {
  description = "The offer of the VM image."
  type        = string
  default     = "0001-com-ubuntu-server-focal"
}

variable "vm_image_sku" {
  description = "The SKU of the VM image."
  type        = string
  default     = "20_04-lts"
}

# Variable for the VM admin username
variable "vm_admin_username" {
  description = "The administrator username for the Virtual Machine."
  type        = string
  default     = "azureuser"
}

# Variable for the path to your SSH public key.
# This is crucial for securely logging into Linux VMs without a password.
variable "public_key_path" {
  description = "The file path to your SSH public key (e.g., ~/.ssh/id_rsa.pub)."
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}


# --- Azure Key Vault Configuration Variables ---
variable "key_vault_name" {
  description = "The globally unique name for the Azure Key Vault."
  type        = string
}

# The 'ssh_public_key_content' variable is now removed from here,
# as its content will be read directly from the file in main.tf.
