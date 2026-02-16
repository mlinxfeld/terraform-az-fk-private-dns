output "storage_account_name" {
  value       = module.storage.storage_account_name
  description = "Storage account name."
}

output "file_share_name" {
  value       = "shared"
  description = "Azure File Share name."
}

output "private_endpoint_id" {
  value       = module.private_endpoint_file.private_endpoint_id
  description = "Private Endpoint (file) ID."
}

output "private_endpoint_private_ip" {
  value       = length(module.private_endpoint_file.private_ip_addresses) > 0 ? module.private_endpoint_file.private_ip_addresses[0] : null
  description = "Private IP of the Private Endpoint NIC."
}

output "vm_private_ips" {
  value       = module.compute[*].vm_private_ip
  description = "Private IPs of the two VMs."
}

output "vm_ssh_private_key_pem" {
  value       = tls_private_key.public_private_key_pair.private_key_pem
  sensitive   = true
  description = "Generated SSH private key (sensitive)."
}
