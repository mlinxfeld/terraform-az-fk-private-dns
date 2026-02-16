variable "name_prefix" {
  description = "Prefix for storage account name (lowercase only). Example: fksa"
  type        = string
  default     = "fksa"
  validation {
    condition     = can(regex("^[a-z0-9]+$", var.name_prefix)) && length(var.name_prefix) <= 10
    error_message = "name_prefix must be lowercase letters/numbers only and max 10 chars."
  }
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "location" {
  description = "Azure region, e.g. westeurope."
  type        = string
  default     = "westeurope"
}

variable "tags" {
  description = "Tags to apply."
  type        = map(string)
  default = {
    project = "terraform-az-fk-private-endpoint"
    example = "03_private_files_with_private_endpoint"
  }
}


# ---- Storage baseline knobs ----
variable "account_tier" {
  type        = string
  default     = "Standard"
  description = "Storage account tier."
}

variable "account_replication_type" {
  type        = string
  default     = "LRS"
  description = "Replication type."
}

variable "account_kind" {
  type        = string
  default     = "StorageV2"
  description = "Storage account kind."
}

variable "access_tier" {
  type        = string
  default     = "Hot"
  description = "Access tier."
}

# ---- File share ----
variable "mount_path" {
  description = "Linux mount path for Azure Files."
  type        = string
  default     = "/mnt/azurefiles"
}

variable "file_share_name" {
  description = "Azure Files Share Name."
  type        = string
  default     = "shared"
}

variable "file_shares" {
  description = <<EOT
Azure File Shares to create (RWX-ready storage layer).

Example:
file_shares = {
  shared = { quota_gb = 100 }
}

quota_gb:
- typical values: 10, 100, 500
EOT
  type = map(object({
    quota_gb    = number
    access_tier = optional(string)
    metadata    = optional(map(string), {})
  }))
  default = {
    shared = {
      quota_gb = 50
      metadata = {
        purpose = "shared"
      }
    }
  }
}

# ---- VM settings ----

variable "vm_number" {
  description = "Number of VMs."
  type        = number
  default     = 2
}

variable "vm_name_prefix" {
  description = "Prefix for VM names."
  type        = string
  default     = "fk-vm"
}

variable "vm_size" {
  description = "VM size."
  type        = string
  default     = "Standard_B1s"
}

variable "vm_admin_username" {
  description = "Admin username for Linux VMs."
  type        = string
  default     = "azureuser"
}

variable "vnet_name" {
  description = "Existing VNet Name to link the Private DNS Zone to."
  type        = string
  default     = "fk-vnet"
}

variable "my_public_ip" {
  description = "Your current public IP address for firewall exception"
  type        = string
  default     = ""
}