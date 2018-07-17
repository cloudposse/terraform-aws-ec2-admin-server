variable "ssh_key_pair" {
  description = "SSH key pair to be provisioned on instance"
}

variable "github_api_token" {
  description = "GitHub API token"
}

variable "github_organization" {
  description = "GitHub organization name"
}

variable "github_team" {
  description = "GitHub team"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "The type of instance that will be created (e.g. `t2.micro`)"
}

variable "vpc_id" {
  description = "The ID of the VPC where the instance will be created"
}

variable "security_groups" {
  type        = "list"
  default     = []
  description = "List of Security Group IDs permitted to connect to this instance"
}

variable "subnets" {
  type        = "list"
  description = "List of VPC Subnet IDs where the instance may be launched"
}

vvariable "name" {
  description = "The Name of the application or solution  (e.g. `bastion` or `portal`)"
}

variable "namespace" {
  description = "Namespace (e.g. `cp` or `cloudposse`)"
}

variable "stage" {
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage`, etc."
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes (e.g. `policy` or `role`)"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`)"
}

variable "ec2_ami" {
  default     = "ami-cd0f5cb6"
  description = "By default it is an AMI provided by Amazon with Ubuntu 16.04"
}

variable "zone_id" {
  default     = ""
  description = "Route53 DNS Zone id"
}

variable "dns_ttl" {
  default     = "60"
  description = "The time for which a DNS resolver caches a response"
}

variable "allow_cidr_blocks" {
  type        = "list"
  default     = ["0.0.0.0/0"]
  description = "List of CIDR blocks to permit SSH access"
}
