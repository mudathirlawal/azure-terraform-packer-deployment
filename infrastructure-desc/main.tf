provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "internal" {
  name                 = "${var.prefix}-sbn"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "main" {
  name                = "${var.prefix}-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "public-inbound-rule"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_network_interface" "main" {
  count               = var.vmCount
  name                = "${var.prefix}-nic-${count.index}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "${var.prefix}-sbn"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "Production"
  }

}

resource "azurerm_public_ip" "main" {
  name                = "${var.prefix}PublicIp1"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_lb" "main" {
  name                = "${var.prefix}LoadBalancer"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  frontend_ip_configuration {
    name                 = "${var.prefix}FrontendPublicIP"
    public_ip_address_id = azurerm_public_ip.main.id
  }

  tags = {
    environment = "Production"
  }  
}

resource "azurerm_lb_backend_address_pool" "main" {
  resource_group_name = azurerm_resource_group.main.name
  loadbalancer_id     = azurerm_lb.main.id
  name                = "${var.prefix}BackEndAddressPool"
}

resource "azurerm_availability_set" "main" {
  name                         = "${var.prefix}-aset"
  location                     = azurerm_resource_group.main.location
  resource_group_name          = azurerm_resource_group.main.name
  
  tags = {
    environment = "Production"
  }
}

data "azurerm_image" "main" {
  name                	= "UbuntuServerPackerImage"
  resource_group_name 	= "packer-images-rg"
}

resource "azurerm_linux_virtual_machine" "main" {
  count                           = var.vmCount 
  name                            = "${var.prefix}-vm-${count.index}"
  resource_group_name             = azurerm_resource_group.main.name
  availability_set_id             = azurerm_availability_set.main.id
  source_image_id                 = data.azurerm_image.main.id
  location                        = azurerm_resource_group.main.location
  size                            = "var.vmSize"
  admin_username                  = "var.adminUserName"
  admin_password                  = "var.adminPassword"
  disable_password_authentication = false
  network_interface_ids           = [
    azurerm_network_interface.main.id,
  ]

  os_disk {
    storage_account_type = "var.storageAccType"
    caching              = "ReadWrite"
  }

  tags = {
    environment = "Production"
  }  
}

resource "azurerm_managed_disk" "main" {
  name                 = "${var.prefix}-mdisk"
  location             = var.location
  resource_group_name  = azurerm_resource_group.main.name
  storage_account_type = "var.storageAccType"
  create_option        = "Empty"
  disk_size_gb         = var.diskSizeGB

  tags = {
    environment = "Production"
  }
}