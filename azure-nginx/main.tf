terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.50"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "nginx" {
  name     = var.resource_group_name
  location = var.azure_region
}

resource "azurerm_virtual_network" "nginx" {
  name                = "nginx-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.nginx.location
  resource_group_name = azurerm_resource_group.nginx.name
}

resource "azurerm_subnet" "nginx" {
  name                 = "nginx-subnet"
  resource_group_name  = azurerm_resource_group.nginx.name
  virtual_network_name = azurerm_virtual_network.nginx.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "nginx" {
  name                = "nginx-nsg"
  location            = azurerm_resource_group.nginx.location
  resource_group_name = azurerm_resource_group.nginx.name

  security_rule {
    name                       = "allow-http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-ssh"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.ssh_allowed_cidr
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nginx" {
  subnet_id                 = azurerm_subnet.nginx.id
  network_security_group_id = azurerm_network_security_group.nginx.id
}

resource "azurerm_public_ip" "nginx" {
  name                = "nginx-public-ip"
  location            = azurerm_resource_group.nginx.location
  resource_group_name = azurerm_resource_group.nginx.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "nginx" {
  name                = "nginx-nic"
  location            = azurerm_resource_group.nginx.location
  resource_group_name = azurerm_resource_group.nginx.name

  ip_configuration {
    name                          = "nginx-ip-config"
    subnet_id                     = azurerm_subnet.nginx.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.nginx.id
  }
}

# SSH key generated locally — public key uploaded to VM, private key saved to disk
resource "tls_private_key" "nginx" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "ssh_private_key" {
  content         = tls_private_key.nginx.private_key_pem
  filename        = "${path.module}/nginx-key.pem"
  file_permission = "0600"
}

resource "azurerm_linux_virtual_machine" "nginx" {
  name                  = "nginx-vm"
  location              = azurerm_resource_group.nginx.location
  resource_group_name   = azurerm_resource_group.nginx.name
  size                  = var.vm_size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.nginx.id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.nginx.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-arm64"
    version   = "latest"
  }

  custom_data = base64encode(<<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx
    systemctl start nginx
    systemctl enable nginx
  EOF
  )
}
