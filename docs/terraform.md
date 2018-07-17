
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allow_cidr_blocks | List of CIDR blocks to permit SSH access | list | `<list>` | no |
| attributes | Additional attributes (e.g. `policy` or `role`) | list | `<list>` | no |
| delimiter | Delimiter to be used between `name`, `namespace`, `stage`, etc. | string | `-` | no |
| dns_ttl | The time for which a DNS resolver caches a response | string | `60` | no |
| ec2_ami | By default it is an AMI provided by Amazon with Ubuntu 16.04 | string | `ami-cd0f5cb6` | no |
| github_api_token | GitHub API token | string | - | yes |
| github_organization | GitHub organization name | string | - | yes |
| github_team | GitHub team | string | - | yes |
| instance_type | The type of instance that will be created (e.g. `t2.micro`) | string | `t2.micro` | no |
| namespace | Namespace (e.g. `cp` or `cloudposse`) | string | - | yes |
| security_groups | List of Security Group IDs permitted to connect to this instance | list | `<list>` | no |
| ssh_key_pair | SSH key pair to be provisioned on instance | string | - | yes |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | string | - | yes |
| subnets | List of VPC Subnet IDs where the instance may be launched | list | - | yes |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')`) | map | `<map>` | no |
| vpc_id | The ID of the VPC where the instance will be created | string | - | yes |
| zone_id | Route53 DNS Zone id | string | `` | no |

## Outputs

| Name | Description |
|------|-------------|
| fqhn | DNS name (Fully Qualified Host Name) of creating instance |
| id | Disambiguated ID |
| public_ip | IPv4 Public IP |
| role | Name of AWS IAM Role associated with creating instance |
| security_group_ids | List of IDs of AWS Security Groups associated with creating instance |
| ssh_key_pair | Name of used AWS SSH key |

