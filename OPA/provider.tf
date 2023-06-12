# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "d665f241-1429-4bd1-bf0d-817bbef17fa8"
  tenant_id       = "e66e412a-b610-48d9-bcde-76325723289e"
  client_id       = "dd2d5809-ccbd-440d-b879-b8b744eb0c26"
  client_secret   = "vJX8Q~t_R7c36ExQsvgDtwgBaei7.~W6IU5M3cYn"
}
terraform {
  cloud {
    organization = "AZURE_Sentinel"

    workspaces {
      name = "OPA"
    }
  }
}