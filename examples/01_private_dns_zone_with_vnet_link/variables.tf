variable "location" {
  type        = string
  description = "Azure region."
  default     = "westeurope"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name."
  default     = "fk-rg"
}

variable "vnet_name" {
  type        = string
  description = "VNet name."
  default     = "fk-vnet"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "VNet address space."
  default     = ["10.10.0.0/16"]
}

variable "private_dns_zone_name" {
  type        = string
  description = "Private DNS zone name."
  default     = "privatelink.blob.core.windows.net"
}

variable "tags" {
  type        = map(string)
  description = "Tags."
  default = {
    project = "foggykitchen"
    module  = "terraform-az-fk-private-dns"
    example = "01_private_dns_zone_with_vnet_link"
  }
}
