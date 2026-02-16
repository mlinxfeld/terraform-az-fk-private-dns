# terraform-az-fk-private-dns

This repository contains a reusable **Terraform / OpenTofu module** and progressive examples for creating **Azure Private DNS Zones** and linking them to **Virtual Networks**.

It is part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/)** and is designed as a dedicated **private DNS layer** for Azure workloads and private endpoints.

---

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
  source = "git::https://github.com/mlinxfeld/terraform-az-fk-private-dns.git?ref=v1.0.0"

  resource_group_name    = "fk-rg"
  private_dns_zone_names = ["privatelink.blob.core.windows.net"]

  vnet_links = {
    fk_vnet = {
      vnet_id              = module.vnet.vnet_id
      registration_enabled = false
    }
  }

  tags = {
    project = "foggykitchen"
    env     = "dev"
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

---

## 🧠 Design Philosophy

- DNS should be **explicitly modeled**, not implied  
- Private DNS is part of the **connectivity story**, not a side detail  
- One module = one responsibility  
- Avoid “magic” defaults — model what Azure actually resolves  

---

## 🧩 Related Modules & Training

- [terraform-az-fk-private-endpoint](https://github.com/mlinxfeld/terraform-az-fk-private-endpoint)  
- [terraform-az-fk-vnet](https://github.com/mlinxfeld/terraform-az-fk-vnet)  
- [terraform-az-fk-storage](https://github.com/mlinxfeld/terraform-az-fk-storage)  
- [terraform-az-fk-compute](https://github.com/mlinxfeld/terraform-az-fk-compute)  
- [terraform-az-fk-aks](https://github.com/mlinxfeld/terraform-az-fk-aks)  

---

## 🪪 License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.  
See [LICENSE](LICENSE) for details.

---

© 2026 FoggyKitchen.com — Cloud. Code. Clarity.
