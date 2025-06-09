# output "resource_group_names" {
#   value = [for rg in azurerm_resource_group.rg : rg.name]
# }
output "rg1_name" {
value = azurerm_resource_group.abc["rg1"].name
}
output "rg1_location" {
value = azurerm_resource_group.abc["rg1"].location
}