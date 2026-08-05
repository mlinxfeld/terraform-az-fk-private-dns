output "private_dns_zone_ids" {
  description = "Map of Private DNS Zone IDs keyed by zone name. Useful for Private Endpoint DNS zone groups."
  value       = { for zone_name, z in azurerm_private_dns_zone.this : zone_name => z.id }
}

output "private_dns_zone_names" {
  description = "List of created Private DNS Zone names."
  value       = [for z in azurerm_private_dns_zone.this : z.name]
}

output "vnet_link_ids" {
  description = "Map of VNet link IDs keyed by '<zone>::<link_name>'."
  value       = { for k, l in azurerm_private_dns_zone_virtual_network_link.this : k => l.id }
}

output "private_dns_a_record_ids" {
  description = "Map of Private DNS A record IDs keyed by record key."
  value       = { for k, r in azurerm_private_dns_a_record.this : k => r.id }
}

output "private_dns_a_record_names" {
  description = "Map of Private DNS A record names keyed by record key."
  value       = { for k, r in azurerm_private_dns_a_record.this : k => r.name }
}
