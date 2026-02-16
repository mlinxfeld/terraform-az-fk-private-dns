output "private_dns_zone_id" {
  value = module.private_dns.private_dns_zone_ids[var.private_dns_zone_name]
}

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "vnet_link_ids" {
  value = module.private_dns.vnet_link_ids
}
