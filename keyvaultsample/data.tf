data "azurerm_key_vault" "name" {
  name = var.key_vault_name
  resource_group_name = azurerm_resource_group.abc["rg1"].name
}

data "azurerm_key_vault_secret" "adminuser"{
    name = "vmadminuser"
    key_vault_id = data.azurerm_key_vault.name.id
}

data "azurerm_key_vault_secret" "password"{
    name = "vmadminpassword"
    key_vault_id = data.azurerm_key_vault.name.id
}
