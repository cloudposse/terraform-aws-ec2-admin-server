# tf_admin

Terraform Module for providing a server capable of running admin tasks. Use `tf_admin` to create and manage an admin instance.

## Usage

Note: add `${var.ssh_key_pair}` private key to the `ssh agent`.

Include this repository as a module in your existing terraform code:

```
module "admin_tier" {
  source                      = "git::https://github.com/cloudposse/tf_admin.git?ref=tags/0.2.0"
  ansible_playbook            = "${var.ansible_playbook}"
  ansible_arguments           = "${var.ansible_arguments}"
  ssh_key_pair                = "${var.ssh_key_pair}"
  github_api_token            = "${var.github_api_token}"
  github_organization         = "${var.github_organization}"
  github_team                 = "${var.github_team}"
  instance_type               = "${var.instance_type}"
  vpc_id                      = "${var.vpc_id}"
  name                        = "admin"
  namespace                   = "${var.namespace}"
  stage                       = "${var.stage}"
  subnets                     = ["${var.subnets}"]
  zone_id                     = "${module.tf_domain.zone_id}"
}

```

This will create a `id`, `fqdn`, `security_group_id`, `role` and `public_ip`.

This module depends on these modules:

* [tf_label](https://github.com/cloudposse/tf_label)
* [tf_github_authorized_keys](https://github.com/cloudposse/tf_github_authorized_keys)
* [tf_ansible](https://github.com/cloudposse/tf_ansible)
* [tf_hostname](https://github.com/cloudposse/tf_hostname)
* [tf_domain](https://github.com/cloudposse/tf_domain) (not directly, but `tf_hostname` need child `zone_id`)

It is necessary to run `terraform get` to download those modules.

Now reference the label when creating an instance (for example):
```
resource "aws_ami_from_instance" "example" {
  name               = "terraform-example"
  source_instance_id = "${module.admin_tier.id}"
}
```

## Variables

|  Name                        |  Default       |  Description                                             | Required             |
|:----------------------------:|:--------------:|:--------------------------------------------------------:|:--------------------:|
| `namespace`                  | `global`       | Namespace (e.g. `cp` or `cloudposse`) - required for `tf_label` module    | Yes |
| `stage`                      | `default`      | Stage (e.g. `prod`, `dev`, `staging` - required for `tf_label` module     | Yes |
| `name`                       | `admin`        | Name  (e.g. `bastion` or `db`) - required for `tf_label` module           | Yes |
| `ec2_ami`                    | `ami-cd0f5cb6` | By default it is an AMI provided by Amazon with Ubuntu 16.04              | No  |
| `ssh_key_pair`               | ``             | SSH key pair to be provisioned on instance                                | Yes |
| `github_api_token`           | ``             | GitHub API token                                                          | Yes |
| `github_organization`        | ``             | GitHub organization name                                                  | Yes |
| `github_team`                | ``             | GitHub team                                                               | Yes |
| `ansible_playbook`           | ``             | Path to the playbook - required for `tf_ansible` (e.g. `./admin_tier.yml`)| Yes |
| `ansible_arguments`          | []             | List of ansible arguments (e.g. `["--user=ubuntu"]`)                      | No  |
| `instance_type`              | `t2.micro`     | The type of the creating instance (e.g. `t2.micro`)                       | No  |
| `vpc_id`                     | ``             | The id of the VPC that the creating instance security group belongs to    | Yes |
| `security_groups`            | []             | List of Security Group IDs allowed to connect to creating instance        | Yes |
| `subnets`                    | []             | List of VPC Subnet IDs creating instance launched in                      | Yes |
| `zone_id`                    | ``             | ID of the domain zone to use - is a result of tf_domain output            | Yes |

## Outputs

| Name                | Decription              |
|:-------------------:|:-----------------------:|
| `id`                | Disambiguated ID        |
| `fqdn`              | Normalized name         |
| `public_ip`         | Normalized namespace    |
| `ssh_key_pair`      | Name of used AWS SSH key|
| `security_group_id` | ID on the new AWS Security Group associated with creating instance|
| `role`              | Name of AWS IAM Role associated with creating instance|


## References
* Thanks to https://github.com/cloudposse/tf_bastion for the inspiration
