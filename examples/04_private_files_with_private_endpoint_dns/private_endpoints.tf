module "private_endpoint_file" {
  source = "github.com/mlinxfeld/terraform-az-fk-private-endpoint"

  name                = "${local.storage_account_name}-pe-file"
  location            = azurerm_resource_group.foggykitchen_rg.location
  resource_group_name = azurerm_resource_group.foggykitchen_rg.name
  subnet_id           = module.vnet.subnet_ids["fk-subnet-private-endpoints"]

  private_connection_resource_id = module.storage.storage_account_id
  subresource_names              = ["file"]
  is_manual_connection           = false

  private_dns_zone_group_name = "default"
  private_dns_zone_ids        = [module.private_dns.private_dns_zone_ids[local.dns_zone_name]]

  tags = var.tags

  depends_on = [
    module.private_dns
  ]
}
