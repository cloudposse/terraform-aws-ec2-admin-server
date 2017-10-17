variable "ssh_key_pair" {}

variable "github_api_token" {}

variable "github_organization" {}

variable "github_team" {}

variable "ansible_playbook" {}

variable "ansible_arguments" {
  type = "list"
}

variable "ansible_envs" {
  type    = "list"
  default = []
}

variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_id" {}

variable "security_groups" {
  type    = "list"
  default = []
}

variable "subnets" {
  type = "list"
}

variable "namespace" {}

variable "stage" {}

variable "name" {}

variable "ec2_ami" {
  default     = "ami-cd0f5cb6"
  description = "Ubuntu Server 16.04 LTS (HVM)"
}

variable "zone_id" {
  default = ""
}

variable "dns_ttl" {
  default = "60"
}
