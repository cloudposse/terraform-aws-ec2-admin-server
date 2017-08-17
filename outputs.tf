output "public_ip" {
  value = "${aws_instance.admin_tier.public_ip}"
}

output "public_hostname" {
  value = "${aws_instance.admin_tier.public_hostname}"
}

output "id" {
  value = "${module.label.id}"
}

output "ssh_key_pair" {
  value = "${var.ssh_key_pair}"
}

output "security_group_id" {
  value = "${aws_security_group.default.id}"
}

output "role" {
  value = "${aws_instance.admin_tier.role}"
}
