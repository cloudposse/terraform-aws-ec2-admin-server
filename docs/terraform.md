<!-- markdownlint-disable -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dns"></a> [dns](#module\_dns) | git::https://github.com/cloudposse/terraform-aws-route53-cluster-hostname.git | tags/0.1.1 |
| <a name="module_instance"></a> [instance](#module\_instance) | git::https://github.com/cloudposse/terraform-aws-ec2-instance.git | tags/0.4.0 |
| <a name="module_label"></a> [label](#module\_label) | git::https://github.com/cloudposse/terraform-null-label.git | tags/0.2.2 |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_cidr_blocks"></a> [allow\_cidr\_blocks](#input\_allow\_cidr\_blocks) | List of CIDR blocks to permit SSH access | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes (e.g. `policy` or `role`) | `list(string)` | `[]` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between `name`, `namespace`, `stage`, etc. | `string` | `"-"` | no |
| <a name="input_dns_ttl"></a> [dns\_ttl](#input\_dns\_ttl) | The time for which a DNS resolver caches a response | `string` | `"60"` | no |
| <a name="input_ec2_ami"></a> [ec2\_ami](#input\_ec2\_ami) | By default it is an AMI provided by Amazon with Ubuntu 16.04 | `string` | `"ami-cd0f5cb6"` | no |
| <a name="input_github_api_token"></a> [github\_api\_token](#input\_github\_api\_token) | GitHub API token | `any` | n/a | yes |
| <a name="input_github_organization"></a> [github\_organization](#input\_github\_organization) | GitHub organization name | `any` | n/a | yes |
| <a name="input_github_team"></a> [github\_team](#input\_github\_team) | GitHub team | `any` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of instance that will be created (e.g. `t2.micro`) | `string` | `"t2.micro"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace (e.g. `cp` or `cloudposse`) | `any` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | List of Security Group IDs permitted to connect to this instance | `list(string)` | `[]` | no |
| <a name="input_ssh_key_pair"></a> [ssh\_key\_pair](#input\_ssh\_key\_pair) | SSH key pair to be provisioned on instance | `any` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage (e.g. `prod`, `dev`, `staging`) | `any` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of VPC Subnet IDs where the instance may be launched | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')`) | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where the instance will be created | `any` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Route53 DNS Zone id | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fqhn"></a> [fqhn](#output\_fqhn) | DNS name (Fully Qualified Host Name) of creating instance |
| <a name="output_id"></a> [id](#output\_id) | Disambiguated ID |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | IPv4 Public IP |
| <a name="output_role"></a> [role](#output\_role) | Name of AWS IAM Role associated with creating instance |
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | List of IDs of AWS Security Groups associated with creating instance |
| <a name="output_ssh_key_pair"></a> [ssh\_key\_pair](#output\_ssh\_key\_pair) | Name of used AWS SSH key |
<!-- markdownlint-restore -->
