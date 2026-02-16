locals {
  // Flatten: create a VNet link for every (zone x vnet_link) pair
  // Key format ensures stable resource addressing across applies.
  zone_vnet_links = merge([
    for zone_name in var.private_dns_zone_names : {
      for link_name, link in var.vnet_links :
      "${zone_name}::${link_name}" => {
        zone_name            = zone_name
        link_name            = link_name
        vnet_id              = link.vnet_id
        registration_enabled = try(link.registration_enabled, false)
      }
    }
  ]...)
}

resource "azurerm_private_dns_zone" "this" {
  for_each = var.private_dns_zone_names

  name                = each.value
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = local.zone_vnet_links

  name                  = each.value.link_name
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this[each.value.zone_name].name

  virtual_network_id    = each.value.vnet_id
  registration_enabled  = each.value.registration_enabled

  tags = var.tags
}
