output "subnet_ids" {
  value = module.vnet.subnet_ids
}

output "acr_private_endpoint_ip" {
  value = var.enable_acr_private_endpoint && length(module.private_endpoint_acr[0].private_ip_addresses) > 0 ? module.private_endpoint_acr[0].private_ip_addresses[0] : null
}
