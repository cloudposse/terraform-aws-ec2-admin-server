# Using tf_admin module

# Apply the tf_label module for this resource
module "label" {
  source    = "git::https://github.com/cloudposse/tf_label.git?ref=tags/0.1.0"
  namespace = "${var.namespace}"
  stage     = "${var.stage}"
  name      = "${var.name}"
}

resource "aws_security_group" "default" {
  name        = "${module.label.id}"
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
module "ap_instance" {
  source              = "git::https://github.com/cloudposse/tf_instance.git?ref=tags/0.1.0"
  playbook            = "${var.playbook}"
  ssh_key_pair        = "${var.ssh_key_pair}"
  github_api_token    = "${var.github_api_token}"
  github_organization = "${var.github_organization}"
  github_team         = "${var.github_team}"
  instance_type       = "t1.micro"
}

data "aws_instance" "admin_tier" {
  instance_id = "${module.label.id}"
}

resource "aws_instance" "admin_tier" {
  ami = "${data.aws_instance.admin_tier.ami}"
  vpc_security_group_ids = [
#    "${compact(concat(list(aws_security_group.default.id), var.security_groups))}"
    "${compact(concat(list(aws_security_group.default.id), data.aws_instance.admin_tier.vpc_security_group_ids))}"
  ]
}

#resource "aws_security_greoupr_rule" "default" {
#  type            = "ingress"
#  from_port       = 0
#  to_port         = 22
#  protocol        = "ssh"
#  cidr_blocks     = ["0.0.0.0/0"]
#
#  security_group_id = "${data.aws_instance.admin_tier.vpc_security_group_ids[0]}"
#}
