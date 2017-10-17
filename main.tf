# Using tf_admin module

resource "aws_security_group_rule" "ssh" {
  from_port         = 22
  protocol          = "-1"
  security_group_id = "${module.instance.security_group_ids}"
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}


# Using terraform-aws-ec2-instance module
module "instance" {
  source                        = "git::https://github.com/cloudposse/terraform-aws-ec2-instance.git?ref=tags/0.3.8"
  namespace                     = "${var.namespace}"
  name                          = "${var.name}"
  stage                         = "${var.stage}"
  vpc_id                        = "${var.vpc_id}"
  subnets                       = "${var.subnets}"
  ansible_arguments             = "${var.ansible_arguments}"
  ansible_playbook              = "${var.ansible_playbook}"
  ansible_envs                  = "${var.ansible_envs}"
  ssh_key_pair                  = "${var.ssh_key_pair}"
  github_api_token              = "${var.github_api_token}"
  github_organization           = "${var.github_organization}"
  github_team                   = "${var.github_team}"
  instance_type                 = "${var.instance_type}"
  create_default_security_group = true

  security_groups = [
    "${compact(concat(list(aws_security_group.default.id), var.security_groups))}",
  ]
}

module "dns" {
  source    = "git::https://github.com/cloudposse/terraform-aws-route53-cluster-hostname.git?ref=tags/0.1.1"
  namespace = "${var.namespace}"
  name      = "${var.name}"
  stage     = "${var.stage}"
  zone_id   = "${var.zone_id}"
  ttl       = "${var.dns_ttl}"
  records   = ["${module.instance.public_dns}"]
}
