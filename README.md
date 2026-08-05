# terraform-az-fk-private-dns

This repository contains a reusable **Terraform / OpenTofu module** and progressive examples for creating **Azure Private DNS Zones** and linking them to **Virtual Networks**.

It is part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses/azure-fundamentals-terraform-course/)** and is designed as a dedicated **private DNS layer** for Azure workloads and private endpoints.

This module is also part of the **[Azure Fundamentals with Terraform/OpenTofu — Build Real-World Azure Architectures with Reusable Modules (2026 Edition)](https://foggykitchen.com/courses/azure-fundamentals-terraform-course/)** course. In the training, it is used to explain how private name resolution supports Azure Private Endpoints and why DNS must be treated as part of the network architecture.

Support expectations are documented in [SUPPORT.md](SUPPORT.md).

---

## Used By

This module is used as a building block by the higher-level [FoggyKitchen Landing Zone Orchestrator](https://github.com/foggykitchen/foggykitchen-landing-zone-orchestrator), where it is composed into Azure, OCI, and multicloud landing zone patterns.

## 🎯 Purpose

The goal of this repository is to provide a **clear, educational, and composable reference implementation**
for **Azure Private DNS** using Infrastructure as Code.

It focuses on:

- Private DNS Zones as **first-class architecture components**
- Explicit modeling of **VNet links** and DNS visibility scope
- Clean integration with **Private Endpoints** and private PaaS services
- Terraform/OpenTofu patterns that reflect **Azure’s DNS resolution model**

This is **not** a landing zone, platform framework, or full network security stack.  
It is a **learning-first building block** designed to integrate cleanly with other FoggyKitchen modules.

---

## ✨ What the module does

Depending on configuration and example used, the module can:

- Create one or more **Private DNS Zones**
- Create **VNet links** for each zone
- Create optional **Private DNS A records**
- Support multiple VNets per zone (via `vnet_links`)
- Provide a clean mapping of **zone IDs** for Private Endpoint DNS integration

The module intentionally does **not** create or manage:

- Virtual Networks or subnets (handled by `terraform-az-fk-vnet`)
- Private Endpoints (handled by `terraform-az-fk-private-endpoint`)
- PaaS services (Storage, ACR, Key Vault, etc.)
- Network Security Groups, firewalls, or routing

Each of those concerns belongs in its own dedicated module.

---

## 📂 Repository Structure

```bash
terraform-az-fk-private-dns/
├── examples/
│   ├── 01_private_dns_zone_with_vnet_link/
│   ├── 02_private_blob_with_private_endpoint_dns/
│   ├── 03_private_acr_with_aks_and_private_endpoint_dns/
│   ├── 04_private_files_with_private_endpoint_dns/
│   └── README.md
├── main.tf
├── inputs.tf
├── outputs.tf
├── versions.tf
├── LICENSE
└── README.md
```

---

## 🚀 Example Usage

### Create a Private DNS Zone and link it to a VNet

```hcl
module "private_dns" {
  source = "git::https://github.com/foggykitchen/terraform-az-fk-private-dns.git?ref=v1.0.0"

  resource_group_name    = "fk-rg"
  private_dns_zone_names = ["privatelink.blob.core.windows.net"]

  vnet_links = {
    fk_vnet = {
      vnet_id              = module.vnet.vnet_id
      registration_enabled = false
    }
  }

  private_dns_a_records = {
    blob = {
      zone_name = "privatelink.blob.core.windows.net"
      name      = "mystorageaccount"
      records   = ["10.0.1.4"]
    }
  }

  tags = {
    project = "foggykitchen"
    env     = "dev"
  }
}
```

When the zone name is known only after apply, use `private_dns_zones` with a
stable logical key and reference that key from records:

```hcl
module "private_dns" {
  source = "git::https://github.com/foggykitchen/terraform-az-fk-private-dns.git?ref=v1.0.0"

  resource_group_name = "fk-rg"

  private_dns_zones = {
    container_apps = {
      name = module.container_app.environment_default_domain
    }
  }

  vnet_links = {
    container_apps = {
      vnet_id              = module.vnet.vnet_id
      registration_enabled = false
    }
  }

  private_dns_a_records = {
    wildcard = {
      zone_key = "container_apps"
      name     = "*"
      records  = [module.container_app.environment_static_ip_address]
    }
  }
}
```

---

## 📤 Outputs

| Output | Description |
|--------|-------------|
| `private_dns_zone_ids` | Map of Private DNS Zone IDs keyed by zone name |
| `private_dns_zone_names` | List of created Private DNS Zone names |
| `vnet_link_ids` | Map of VNet link IDs keyed by `<zone>::<link_name>` |
| `private_dns_a_record_ids` | Map of Private DNS A record IDs keyed by record key |
| `private_dns_a_record_names` | Map of Private DNS A record names keyed by record key |

---

## 🧠 Design Philosophy

- DNS should be **explicitly modeled**, not implied  
- Private DNS is part of the **connectivity story**, not a side detail  
- One module = one responsibility  
- Avoid “magic” defaults — model what Azure actually resolves  

---

## 🧩 Related Modules & Training

- [terraform-az-fk-private-endpoint](https://github.com/foggykitchen/terraform-az-fk-private-endpoint)  
- [terraform-az-fk-vnet](https://github.com/foggykitchen/terraform-az-fk-vnet)  
- [terraform-az-fk-storage](https://github.com/foggykitchen/terraform-az-fk-storage)  
- [terraform-az-fk-compute](https://github.com/mlinxfeld/terraform-az-fk-compute)  
- [terraform-az-fk-aks](https://github.com/mlinxfeld/terraform-az-fk-aks)  

---

## 🪪 License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.  
See [LICENSE](LICENSE) for details.

---

© 2026 [FoggyKitchen.com](https://foggykitchen.com) - Cloud. Code. Clarity.
