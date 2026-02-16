resource "azurerm_container_registry" "foggykitchen_acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.foggykitchen_rg.name
  location            = var.location

  sku           = var.acr_sku
  admin_enabled = false

  tags = var.tags
}

