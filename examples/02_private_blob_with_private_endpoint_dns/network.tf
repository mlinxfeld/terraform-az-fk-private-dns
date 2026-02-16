module "vnet" {
  source = "github.com/mlinxfeld/terraform-az-fk-vnet"

  name                = var.vnet_name
  location            = azurerm_resource_group.foggykitchen_rg.location
  resource_group_name = azurerm_resource_group.foggykitchen_rg.name

  address_space = ["10.10.0.0/16"]

  subnets = {
    fk-subnet-private-endpoints = {
        address_prefixes = ["10.10.20.0/24"]
        service_endpoints = ["Microsoft.Storage"]
    }
  }

  tags = var.tags
}