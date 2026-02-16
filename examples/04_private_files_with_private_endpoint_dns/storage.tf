module "storage" {
  source = "github.com/mlinxfeld/terraform-az-fk-storage"

  name                = local.storage_account_name
  location            = azurerm_resource_group.foggykitchen_rg.location
  resource_group_name = azurerm_resource_group.foggykitchen_rg.name

  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind
  access_tier              = var.access_tier

  https_traffic_only_enabled = true
  min_tls_version            = "TLS1_2"

  public_network_access_enabled = true
  enable_network_rules = true

  network_rules = {
    default_action = "Deny"
    ip_rules = [
      var.my_public_ip
    ]
    virtual_network_subnet_ids = [
      module.vnet.subnet_ids["fk-subnet-private-vm"]
    ]
    bypass = ["AzureServices"]
  }

  # We create a File Share in this example
  create_file_shares = true 
  file_shares        = var.file_shares 

  # keep example focused
  create_containers    = false

  tags = var.tags

  depends_on = [module.vnet]
}
