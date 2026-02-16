locals {
  storage_account_name = "${var.name_prefix}${random_string.suffix.result}"

  # Private Link DNS for Azure Files
  dns_zone_name = "privatelink.file.core.windows.net"

  mount_path = "/mnt/azurefiles"
  fqdn       = "${module.storage.storage_account_name}.file.core.windows.net"

  vm_cloud_init = base64encode(templatefile("${path.module}/cloud-init-azurefiles.yaml.tpl", {
    storage_account_name = module.storage.storage_account_name
    storage_account_key  = module.storage.primary_access_key
    file_share_name      = var.file_share_name
    mount_path           = local.mount_path
    fqdn                 = local.fqdn
  }))
}