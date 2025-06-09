resource "azurerm_resource_group" "abc" {
    for_each = var.resourcegroup
  name = each.key
  location = each.value.location
 # tags = each.value.tags
}
resource "azurerm_storage_account" "abc" {
  resource_group_name = azurerm_resource_group.abc["rg1"].name
  location    = azurerm_resource_group.abc["rg1"].location
  account_tier = "Standard"
  account_replication_type = "LRS"
  name = "jatintesting1234"
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = "jatindemo"
  resource_group_name = azurerm_resource_group.abc["rg1"].name
  location            = azurerm_resource_group.abc["rg1"].location
  size                = "Standard_B1s"
  admin_username      = data.azurerm_key_vault_secret.adminuser.value
  admin_password      = data.azurerm_key_vault_secret.password.value
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "jatindemo-osdisk"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = azurerm_resource_group.abc["rg1"].location
  resource_group_name = azurerm_resource_group.abc["rg1"].name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.vm_name}-ip"
  location            = azurerm_resource_group.abc["rg1"].location
  resource_group_name = azurerm_resource_group.abc["rg1"].name
  allocation_method   = "Static"
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.vm_name}-subnet"
  resource_group_name  = azurerm_resource_group.abc["rg1"].name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.vm_name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.abc["rg1"].location
  resource_group_name = azurerm_resource_group.abc["rg1"].name
}
