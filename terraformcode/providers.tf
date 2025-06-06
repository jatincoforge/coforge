provider "azurerm" {
  features {}
  subscription_id = "b48e5e8d-ace6-4c1c-832d-732fd926c653"
  client_id = "35f2a674-2edc-4e52-a055-6367a9c4ed50"
  client_secret = "9b.8Q~Yx2.3LUt2nPajj5wob~rr_6pcT_TfFOby6"
  tenant_id = "923b6ece-1052-4b26-a6d7-a34e9d15591d"
}

 terraform {
   backend "azurerm" {}
 }
