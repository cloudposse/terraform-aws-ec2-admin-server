
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allow_cidr_blocks |  | list | `<list>` | no |
| attributes |  | list | `<list>` | no |
| delimiter |  | string | `-` | no |
| dns_ttl |  | string | `60` | no |
| ec2_ami | Ubuntu Server 16.04 LTS (HVM) | string | `ami-cd0f5cb6` | no |
| github_api_token |  | string | - | yes |
| github_organization |  | string | - | yes |
| github_team |  | string | - | yes |
| instance_type |  | string | `t2.micro` | no |
| name |  | string | - | yes |
| namespace |  | string | - | yes |
| security_groups |  | list | `<list>` | no |
| ssh_key_pair |  | string | - | yes |
| stage |  | string | - | yes |
| subnets |  | list | - | yes |
| tags |  | map | `<map>` | no |
| vpc_id |  | string | - | yes |
| zone_id |  | string | `` | no |

## Outputs

| Name | Description |
|------|-------------|
| fqhn | DNS name (Fully Qualified Host Name) of creating instance |
| id | Disambiguated ID |
| public_ip | IPv4 Public IP |
| role | Name of AWS IAM Role associated with creating instance |
| security_group_ids | List of IDs of AWS Security Groups associated with creating instance |
| ssh_key_pair | Name of used AWS SSH key |

