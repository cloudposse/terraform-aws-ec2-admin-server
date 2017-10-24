output "public_ip" {
  value = "${module.instance.public_ip}"
}

output "id" {
  value = "${module.instance.id}"
}

output "ssh_key_pair" {
  value = "${var.ssh_key_pair}"
}

output "role" {
  value = "${module.instance.role}"
}

output "fqhn" {
  value = "${module.dns.hostname}"
}

output "security_group_ids" {
  value = "module.instance.security_group_ids"
}
