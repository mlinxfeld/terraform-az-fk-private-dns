# Azure Private DNS with Terraform / OpenTofu — Examples

This directory contains **hands-on Azure Private DNS examples** built around the
`terraform-az-fk-private-dns` module.

The examples are designed as **progressive building blocks** that introduce how
Private DNS Zones and VNet links work on their own, and how they integrate with
Private Endpoints for Storage and ACR workloads.

They are part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/)** and are used across:

- Azure Fundamentals with Terraform / OpenTofu  
- Azure Networking & Security design notes  
- Private PaaS connectivity patterns  
- AKS private image pull scenarios  
- Multicloud (Azure + OCI) architectural training  

---

## 🧭 Example Overview

| Example | Title | Key Topics |
|--------|-------|------------|
| 01 | **Private DNS Zone with VNet Link** | Private DNS baseline, VNet link |
| 02 | **Private Blob with Private Endpoint + DNS** | Blob private endpoint with DNS module |
| 03 | **Private ACR with AKS + Private Endpoint + DNS** | AKS image pull with ACR via private DNS |
| 04 | **Private Azure Files + Private Endpoint + DNS** | SMB access to Azure Files from private VMs |

Each example introduces **one clear DNS/Private Endpoint concept** and can be applied
**independently** for learning, experimentation, or reuse.

---

## ⚙️ How to Use

Each example directory contains:

- Terraform / OpenTofu configuration (`.tf`)
- A focused `README.md` explaining the architectural goal
- Architecture diagrams and Azure Portal verification screenshots
- A **fully runnable deployment** (no placeholders, no mock resources)

To run an example:

```bash
cd examples/01_private_dns_zone_with_vnet_link
tofu init
tofu plan
tofu apply
```

Examples may be deployed independently, but the **recommended learning path** is:

```
01 → 02 → 03 → 04
```

---

## 🧩 Design Principles

These examples follow strict design rules:

- One example = one architectural concept  
- Explicit modeling of:
  - Private DNS zones
  - VNet links
  - Private Endpoint integration  
- Clear separation of concerns:
  - DNS (this module)  
  - Private connectivity (Private Endpoint module)  
  - PaaS services (Storage / ACR)  
  - Compute (VM / AKS), where applicable  
- No hidden magic or implicit routing  
- All traffic paths are visible in Terraform  

The goal is **clarity and correctness**, not completeness.

---

## 🔗 Related Modules & Training

- [terraform-az-fk-private-dns](https://github.com/mlinxfeld/terraform-az-fk-private-dns) (this repository)  
- [terraform-az-fk-private-endpoint](https://github.com/mlinxfeld/terraform-az-fk-private-endpoint)  
- [terraform-az-fk-vnet](https://github.com/mlinxfeld/terraform-az-fk-vnet)  
- [terraform-az-fk-storage](https://github.com/mlinxfeld/terraform-az-fk-storage)  
- [terraform-az-fk-compute](https://github.com/mlinxfeld/terraform-az-fk-compute)  
- [terraform-az-fk-aks](https://github.com/mlinxfeld/terraform-az-fk-aks)  

---

## 🪪 License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.  
See `LICENSE` for details.

---

© 2026 FoggyKitchen.com — Cloud. Code. Clarity.
