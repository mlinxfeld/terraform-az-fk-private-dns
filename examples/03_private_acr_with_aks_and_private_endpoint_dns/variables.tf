variable "resource_group_name" {
  description = "The name of the Azure Resource Group where resources will be created"
  type        = string
}

variable "location" {
  description = "Azure region (e.g., East US, West Europe)"
  type        = string
}

variable "vnet_name" {
  type    = string
  default = "fk-vnet-aks"
}

variable "acr_name" {
  type    = string
  default = "fkacrprivate"
}

variable "acr_sku" {
  type        = string
  description = "ACR SKU (Basic, Standard, Premium). Premium required for Private Endpoint."
  default     = "Premium"
}

variable "enable_acr_private_endpoint" {
  type        = bool
  description = "Enable Private Endpoint for ACR (requires Premium SKU)"
  default     = true
}

variable "enable_private_dns" {
  type        = bool
  description = "Create and link Private DNS zone for ACR Private Endpoint (privatelink.azurecr.io)"
  default     = true
}

variable "tags" {
  description = "Tags to apply."
  type        = map(string)
  default = {
    project = "terraform-az-fk-private-endpoint"
    example = "02_private_acr_with_aks_and_private_endpoint"
  }
}
