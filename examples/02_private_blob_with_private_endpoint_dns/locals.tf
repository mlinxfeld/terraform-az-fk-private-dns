locals {
  storage_account_name = "${var.name_prefix}${random_string.suffix.result}"
  pe_name              = "${local.storage_account_name}-pe-blob"
  dns_zone_name        = "privatelink.blob.core.windows.net"
}