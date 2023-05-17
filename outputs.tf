output "public_ip" {
  value       = module.instance.public_ip
  description = "IPv4 Public IP"
}

output "id" {
  value       = module.instance.id
  description = "Disambiguated ID"
}

output "ssh_key_pair" {
  value       = var.ssh_key_pair
  description = "Name of used AWS SSH key "
}

output "role" {
  value       = module.instance.role
  description = "Name of AWS IAM Role associated with creating instance"
}

output "fqhn" {
  value       = module.dns.hostname
  description = "DNS name (Fully Qualified Host Name) of creating instance"
}

output "security_group_ids" {
  value       = module.instance.security_group_ids
  description = "List of IDs of AWS Security Groups associated with creating instance"
}
