resource "azurerm_resource_group" "abc" {
    for_each = var.resourcegroup
  name = each.key
  location = each.value.location
}
resource "azurerm_storage_account" "abc" {
  resource_group_name = azurerm_resource_group.abc["rg1"].name
  location    = azurerm_resource_group.abc["rg1"].location
  account_tier = "Standard"
  account_replication_type = "LRS"
  name = "jatintesting1234"
}