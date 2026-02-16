module "storage" {
  source = "github.com/mlinxfeld/terraform-az-fk-storage"

  name                = local.storage_account_name
  resource_group_name = azurerm_resource_group.foggykitchen_rg.name
  location            = azurerm_resource_group.foggykitchen_rg.location

  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind
  access_tier              = var.access_tier

  https_traffic_only_enabled = true
  min_tls_version            = "TLS1_2"

  public_network_access_enabled = true
  enable_network_rules = var.enable_network_rules

  network_rules = {
    default_action = var.network_rules_default_action
    ip_rules = var.my_public_ip != "" ? [var.my_public_ip] : []
    virtual_network_subnet_ids = [
      module.vnet.subnet_ids["fk-subnet-private-endpoints"]
    ]
    bypass = ["AzureServices"]
  }

  # Enable blob containers in this example
  create_containers = true
  containers        = var.containers

  create_file_shares   = false

  tags = var.tags
}
