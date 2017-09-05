# Using tf_admin module

# Apply the tf_label module for this resource
module "label" {
  source    = "git::https://github.com/cloudposse/tf_label.git?ref=tags/0.1.0"
  namespace = "${var.namespace}"
  stage     = "${var.stage}"
  name      = "${var.name}"
}

resource "aws_security_group" "default" {
  name        = "${module.label.id}-public_ssh"
  vpc_id      = "${var.vpc_id}"
  description = "Instance default security group (only egress access is allowed)"

  tags {
    Name      = "${module.label.id}"
    Namespace = "${var.namespace}"
    Stage     = "${var.stage}"
  }

  ingress {
    protocol  = "ssh"
    from_port = 0
    to_port   = 22

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  egress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Using tf_instance module
module "instance" {
  source              = "git::https://github.com/cloudposse/tf_instance.git?ref=tags/0.2.0"
  namespace           = "${var.namespace}"
  name                = "${var.name}"
  stage               = "${var.stage}"
  vpc_id              = "${var.vpc_id}"
  subnets             = "${var.subnets}"
  ansible_arguments   = "${var.ansible_arguments}"
  ansible_playbook    = "${var.ansible_playbook}"
  ssh_key_pair        = "${var.ssh_key_pair}"
  github_api_token    = "${var.github_api_token}"
  github_organization = "${var.github_organization}"
  github_team         = "${var.github_team}"
  instance_type       = "${var.instance_type}"

  security_groups = [
    "${compact(concat(list(aws_security_group.default.id), var.security_groups))}",
  ]
}

module "dns" {
  source    = "git::https://github.com/cloudposse/tf_hostname.git?ref=tags/0.1.0"
  namespace = "${var.namespace}"
  name      = "${var.name}"
  stage     = "${var.stage}"
  zone_id   = "${var.zone_id}"
  ttl       = "${var.dns_ttl}"
  records   = ["${module.instance.public_hostname}"]
}
