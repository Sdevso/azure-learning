
# Provider configuration for Azure Resource Manager.
# The 'features {}' block is required by the AzureRM provider.
provider "azurerm" {
  features {}
}

# Resource to generate a random hexadecimal string.
# This is used as a suffix for resource names that require global uniqueness
# or simply to avoid naming conflicts across different deployments.
resource "random_id" "resource_suffix" {
  byte_length = 4 # Generates an 8-character hexadecimal string (e.g., "a1b2c3d4")
}

# --- Azure Resource Group ---
# 1. Creates an Azure Resource Group, which acts as a logical container
#    for all the related resources of this deployment (VM, network, Key Vault, etc.).
resource "azurerm_resource_group" "main" {
  name     = "${var.resource_group_name_prefix}-${random_id.resource_suffix.hex}"
  location = var.location # Location for the RG, provided via variables
  tags = {
    Environment = var.environment_tag # Tag for environment identification
    Purpose     = "TerraformVMDeployment"
  }
}

# --- Azure Virtual Network (VNet) ---
# 2. Creates a Virtual Network, providing a private and isolated network space in Azure.
#    VMs will reside within this VNet.
resource "azurerm_virtual_network" "main" {
  name                = "${var.vnet_name_prefix}-${random_id.resource_suffix.hex}"
  address_space       = [var.vnet_address_space]             # Defines the IP address range for the VNet
  location            = azurerm_resource_group.main.location # Inherits location from the Resource Group
  resource_group_name = azurerm_resource_group.main.name     # Places VNet within the Resource Group

  tags = {
    Environment = var.environment_tag
    ManagedBy   = "Terraform"
  }
}

# --- Azure Subnet ---
# 3. Creates a Subnet within the VNet. Subnets allow for logical segmentation
#    of the network and control over traffic flow.
resource "azurerm_subnet" "main" {
  name                 = "${var.subnet_name_prefix}-${random_id.resource_suffix.hex}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name # Links to the created VNet
  address_prefixes     = [var.subnet_address_prefix]       # Defines the IP address range for the Subnet
}

# --- Azure Public IP Address ---
# 4. Creates a Public IP Address. This is optional but recommended for direct SSH/RDP access
#    to the VM from the internet for testing/learning. For production, consider using
#    Azure Bastion or a VPN for more secure access.
resource "azurerm_public_ip" "main" {
  name                = "${var.vm_name}-public-ip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static" # 'Static' ensures the IP address remains constant
  sku                 = "Basic"  # Basic SKU is suitable for single VMs
  tags = {
    Environment = var.environment_tag
  }
}

# --- Azure Network Interface (NIC) ---
# 5. Creates a Network Interface, which is the virtual network adapter for the VM.
#    It connects the VM to the Subnet and optionally assigns a Public IP.
resource "azurerm_network_interface" "main" {
  name                = "${var.vm_name}-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id    # Links the NIC to the created Subnet
    private_ip_address_allocation = "Dynamic"                 # Dynamically assigns a private IP from the Subnet
    public_ip_address_id          = azurerm_public_ip.main.id # Links the Public IP to this NIC
  }
  tags = {
    Environment = var.environment_tag
  }
}

# --- Azure Key Vault for SSH Key Management ---
# This section demonstrates a secure way to manage SSH public keys using Azure Key Vault.
# Instead of hardcoding keys or passing them as sensitive variables, they are stored
# in a centralized, secure vault.

# 7. Creates an Azure Key Vault instance.
#    Key Vault names must be globally unique across all Azure.
resource "azurerm_key_vault" "main" {
  # Constructs the globally unique name using a variable prefix and the random suffix.
  name                        = "${var.key_vault_name}${random_id.resource_suffix.hex}"
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  enabled_for_disk_encryption = true                                         # Enable if you plan to use Key Vault for disk encryption
  tenant_id                   = data.azurerm_client_config.current.tenant_id # Retrieves your Azure Tenant ID
  sku_name                    = "standard"                                   # Standard SKU is generally cost-effective and suitable for learning

  tags = {
    Environment = var.environment_tag
    Purpose     = "SSHKeyStorage"
  }
}

# Data source to retrieve the current Azure CLI client's configuration.
# This is used to get the Tenant ID and the Object ID (your user or service principal ID)
# which are required for setting Key Vault access policies.
data "azurerm_client_config" "current" {}

# 8. Sets an Access Policy for the Key Vault.
#    This policy grants the identity running Terraform (your 'az login' user or service principal)
#    permissions to interact with secrets in the Key Vault.
resource "azurerm_key_vault_access_policy" "current_user_policy" {
  key_vault_id = azurerm_key_vault.main.id # Links to the created Key Vault
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id # The ID of your Azure identity

  secret_permissions = [
    "Set", # Permission to create/update secrets
    "Get", # Permission to read secrets
    "List" # Permission to list secrets
  ]
}

# 9. Stores the SSH Public Key as a Secret in Azure Key Vault.
#    The content of your local SSH public key file is read and then stored securely.
resource "azurerm_key_vault_secret" "ssh_public_key_secret" {
  name = "linux-vm-ssh-public-key"
  # Dynamically reads the content of the public key file from your local machine.
  # 'pathexpand()' resolves the '~' (user home directory) in the path.
  # 'file()' reads the content of the file at the resolved path.
  value        = file(pathexpand(var.public_key_path))
  key_vault_id = azurerm_key_vault.main.id # Links to the created Key Vault

  # Ensures the access policy is set before attempting to create the secret.
  depends_on = [azurerm_key_vault_access_policy.current_user_policy]
}

# --- Azure Linux Virtual Machine ---
# 6. Defines the actual Linux Virtual Machine instance.
resource "azurerm_linux_virtual_machine" "main" {
  name                            = var.vm_name
  location                        = azurerm_resource_group.main.location
  resource_group_name             = azurerm_resource_group.main.name
  size                            = var.vm_size
  admin_username                  = var.vm_admin_username
  disable_password_authentication = true # Crucial for SSH key-based access (disables password login)

  # Links the VM to its network interface.
  network_interface_ids = [
    azurerm_network_interface.main.id
  ]

  # Defines the Operating System Disk properties.
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS" # Standard HDD is a good cost-effective choice for learning
    name                 = "${var.vm_name}-osdisk"
    # 'create_option = "FromImage"' is implicitly handled when 'source_image_reference' is used.
  }

  # Specifies the source image for the VM's operating system.
  source_image_reference {
    publisher = var.vm_image_publisher
    offer     = var.vm_image_offer
    sku       = var.vm_image_sku
    version   = "latest" # Always pulls the latest available version of the specified image
  }

  # Configures SSH Public Key authentication for the VM.
  # The public key content is retrieved securely from Azure Key Vault.
  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = azurerm_key_vault_secret.ssh_public_key_secret.value # Fetches the key content from Key Vault
  }

  tags = {
    Environment = var.environment_tag
    Purpose     = "LinuxVM"
  }
}
