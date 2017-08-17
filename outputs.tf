output "public_ip" {
  value = "${module.instance.public_ip}"
}

output "public_hostname" {
  value = "${module.instance.public_hostname}"
}

output "id" {
  value = "${module.instance.id}"
}

output "ssh_key_pair" {
  value = "${var.ssh_key_pair}"
}

output "security_group_id" {
  value = "${aws_security_group.default.id}"
}

output "role" {
  value = "${module.instance.role}"
}

