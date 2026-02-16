module "private_dns" {
  source = "../../" 

  resource_group_name    = azurerm_resource_group.fk_rg.name
  private_dns_zone_names = [var.private_dns_zone_name]
  tags                   = var.tags

  vnet_links = {
    "${var.vnet_name}-link" = {
      vnet_id              = module.vnet.vnet_id
      registration_enabled = false
    }
  }
}
