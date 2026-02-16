module "aks" {
  source              = "github.com/mlinxfeld/terraform-az-fk-aks"
  name                = "fk-aks-demo"
  location            = azurerm_resource_group.foggykitchen_rg.location
  resource_group_name = azurerm_resource_group.foggykitchen_rg.name
  
  vnet_id   = module.vnet.vnet_id
  subnet_id = module.vnet.subnet_ids["fk-subnet-aks"]

  tags = var.tags
}
