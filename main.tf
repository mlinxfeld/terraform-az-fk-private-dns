locals {
  private_dns_zones = merge(
    { for zone_name in var.private_dns_zone_names : zone_name => { name = zone_name } },
    var.private_dns_zones
  )

  // Flatten: create a VNet link for every (zone x vnet_link) pair
  // Key format ensures stable resource addressing across applies.
  zone_vnet_links = merge([
    for zone_key, zone in local.private_dns_zones : {
      for link_name, link in var.vnet_links :
      "${zone_key}::${link_name}" => {
        zone_key             = zone_key
        zone_name            = zone.name
        link_name            = link_name
        vnet_id              = link.vnet_id
        registration_enabled = try(link.registration_enabled, false)
      }
    }
  ]...)
}

resource "azurerm_private_dns_zone" "this" {
  for_each = local.private_dns_zones

  name                = each.value.name
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = local.zone_vnet_links

  name                  = each.value.link_name
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this[each.value.zone_key].name

  virtual_network_id   = each.value.vnet_id
  registration_enabled = each.value.registration_enabled

  tags = var.tags
}

resource "azurerm_private_dns_a_record" "this" {
  for_each = var.private_dns_a_records

  name                = each.value.name
  zone_name           = azurerm_private_dns_zone.this[coalesce(try(each.value.zone_key, null), try(each.value.zone_name, null))].name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records

  depends_on = [azurerm_private_dns_zone_virtual_network_link.this]
}
