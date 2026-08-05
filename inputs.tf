variable "resource_group_name" {
  description = "Name of the Azure Resource Group where Private DNS Zones and VNet links will be created."
  type        = string
}

variable "private_dns_zone_names" {
  description = <<EOT
List of Private DNS Zone names to create.
Examples:
- privatelink.blob.core.windows.net
- privatelink.file.core.windows.net
- privatelink.vaultcore.azure.net
EOT
  type        = set(string)

  validation {
    condition     = length(var.private_dns_zone_names) > 0
    error_message = "private_dns_zone_names must contain at least one DNS zone name."
  }
}

variable "vnet_links" {
  description = <<EOT
Map of VNet links to create for each Private DNS Zone.

Example:
vnet_links = {
  fk_vnet = {
    vnet_id               = module.vnet.vnet_id
    registration_enabled  = false
  }
}

Notes:
- registration_enabled is typically false for privatelink.* zones.
- set to true only if you intentionally want auto-registration for VM hostnames (usually for custom zones).
EOT

  type = map(object({
    vnet_id              = string
    registration_enabled = optional(bool, false)
  }))

  default = {}

  validation {
    condition     = alltrue([for k, v in var.vnet_links : length(trimspace(v.vnet_id)) > 0])
    error_message = "Each vnet_links entry must include a non-empty vnet_id."
  }
}

variable "private_dns_a_records" {
  description = "Map of Private DNS A records to create."
  type = map(object({
    zone_name = string
    name      = string
    ttl       = optional(number, 300)
    records   = list(string)
  }))
  default = {}

  validation {
    condition = alltrue([
      for record in var.private_dns_a_records :
      contains(var.private_dns_zone_names, record.zone_name)
    ])
    error_message = "Each private_dns_a_records entry must reference a zone from private_dns_zone_names."
  }

  validation {
    condition = alltrue([
      for record in var.private_dns_a_records :
      length(record.records) > 0
    ])
    error_message = "Each private_dns_a_records entry must include at least one IP address."
  }
}

variable "tags" {
  description = "Tags to apply to all resources created by this module."
  type        = map(string)
  default     = {}
}
