module "vnet" {
  source = "github.com/mlinxfeld/terraform-az-fk-vnet"

  name                = var.vnet_name
  location            = azurerm_resource_group.fk_rg.location
  resource_group_name = azurerm_resource_group.fk_rg.name
  address_space       = var.vnet_address_space

  subnets = {
    fk-subnet-private = {
      address_prefixes = ["10.10.1.0/24"]
    }
  }

  tags = var.tags
}
