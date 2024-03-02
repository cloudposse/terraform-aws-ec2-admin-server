# Define label for SG and SG itself

module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.25.0"
  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  attributes = compact(concat(var.attributes, list("ssh")))
  delimiter  = var.delimiter
  tags       = var.tags
}

resource "aws_security_group" "default" {
  name        = module.label.id
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id
  tags        = module.label.tags
}

resource "aws_security_group_rule" "ssh" {
  from_port         = 22
  protocol          = "-1"
  security_group_id = aws_security_group.default.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = var.allow_cidr_blocks
}

resource "aws_security_group_rule" "egress" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.default.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Use terraform-aws-ec2-instance module
module "instance" {
  source                        = "git::https://github.com/cloudposse/terraform-aws-ec2-instance.git?ref=tags/0.4.0"
  namespace                     = var.namespace
  name                          = var.name
  stage                         = var.stage
  attributes                    = var.attributes
  delimiter                     = var.delimiter
  tags                          = var.tags
  vpc_id                        = var.vpc_id
  subnets                       = var.subnets
  ssh_key_pair                  = var.ssh_key_pair
  github_api_token              = var.github_api_token
  github_organization           = var.github_organization
  github_team                   = var.github_team
  instance_type                 = var.instance_type
  create_default_security_group = false

  security_groups = [
    "${compact(concat(list(aws_security_group.default.id), var.security_groups))}",
  ]
}

module "dns" {
  source    = "git::https://github.com/cloudposse/terraform-aws-route53-cluster-hostname.git?ref=tags/0.1.1"
  namespace = var.namespace
  name      = var.name
  stage     = var.stage
  zone_id   = var.zone_id
  ttl       = var.dns_ttl
  records   = ["${module.instance.public_dns}"]
}
