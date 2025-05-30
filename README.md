

<!-- markdownlint-disable -->
<a href="https://cpco.io/homepage"><img src="https://github.com/cloudposse/terraform-aws-ec2-admin-server/blob/main/.github/banner.png?raw=true" alt="Project Banner"/></a><br/>
    <p align="right">
<a href="https://github.com/cloudposse/terraform-aws-ec2-admin-server/releases/latest"><img src="https://img.shields.io/github/release/cloudposse/terraform-aws-ec2-admin-server.svg?style=for-the-badge" alt="Latest Release"/></a><a href="https://github.com/cloudposse/terraform-aws-ec2-admin-server/commits"><img src="https://img.shields.io/github/last-commit/cloudposse/terraform-aws-ec2-admin-server.svg?style=for-the-badge" alt="Last Updated"/></a><a href="https://cloudposse.com/slack"><img src="https://slack.cloudposse.com/for-the-badge.svg" alt="Slack Community"/></a></p>
<!-- markdownlint-restore -->

<!--




  ** DO NOT EDIT THIS FILE
  **
  ** This file was automatically generated by the `cloudposse/build-harness`.
  ** 1) Make all changes to `README.yaml`
  ** 2) Run `make init` (you only need to do this once)
  ** 3) Run`make readme` to rebuild this file.
  **
  ** (We maintain HUNDREDS of open source projects. This is how we maintain our sanity.)
  **





-->

Terraform Module for providing a server capable of running admin tasks. Use `terraform-aws-ec2-admin-server` to create and manage an admin instance.


> [!TIP]
> #### 👽 Use Atmos with Terraform
> Cloud Posse uses [`atmos`](https://atmos.tools) to easily orchestrate multiple environments using Terraform. <br/>
> Works with [Github Actions](https://atmos.tools/integrations/github-actions/), [Atlantis](https://atmos.tools/integrations/atlantis), or [Spacelift](https://atmos.tools/integrations/spacelift).
>
> <details>
> <summary><strong>Watch demo of using Atmos with Terraform</strong></summary>
> <img src="https://github.com/cloudposse/atmos/blob/main/docs/demo.gif?raw=true"/><br/>
> <i>Example of running <a href="https://atmos.tools"><code>atmos</code></a> to manage infrastructure from our <a href="https://atmos.tools/quick-start/">Quick Start</a> tutorial.</i>
> </detalis>





## Usage

Note: add `${var.ssh_key_pair}` private key to the `ssh agent`.

Include this repository as a module in your existing terraform code:

```terraform
module "admin_tier" {
  source                      = "git::https://github.com/cloudposse/terraform-aws-ec2-admin-server.git?ref=master"
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
  zone_id                     = "${module.terraform-aws-route53-cluster-zone.zone_id}"
  security_groups             = ["${var.security_groups}"]
  allow_cidr_blocks           = ["${var.allow_cidr_blocks}"]
}

```

### Module `terraform-aws-route53-cluster-zone`

Module `terraform-aws-ec2-admin-server` requires another module to be used additionally - `terraform-aws-route53-cluster-zone`.

`terraform-aws-ec2-admin-server` uses `terraform-aws-route53-cluster-hostname` to create a DNS record for created host. `terraform-aws-route53-cluster-hostname` module needs `zone_id` parameter as an input, and this parameter actually is an output from `terraform-aws-route53-cluster-zone`.

That is why `terraform-aws-route53-cluster-zone` should be implemented in `root` TF manifest when we need `terraform-aws-ec2-admin-server`.


### This module depends on the next modules:

* [terraform-null-label](https://github.com/cloudposse/terraform-null-label)
* [terraform-aws-ubuntu-github-authorized-keys-user-data](https://github.com/cloudposse/terraform-aws-ubuntu-github-authorized-keys-user-data)
* [terraform-aws-route53-cluster-hostname](https://github.com/cloudposse/terraform-aws-route53-cluster-hostname)
* [terraform-aws-route53-cluster-zone](https://github.com/cloudposse/terraform-aws-route53-cluster-zone) (not directly, but `terraform-aws-route53-cluster-hostname` need child `zone_id`)

It is necessary to run `terraform get` to download those modules.

Now reference the label when creating an instance (for example):
```terraform
resource "aws_ami_from_instance" "example" {
  name               = "terraform-example"
  source_instance_id = "${module.admin_tier.id}"
}
```

> [!IMPORTANT]
> In Cloud Posse's examples, we avoid pinning modules to specific versions to prevent discrepancies between the documentation
> and the latest released versions. However, for your own projects, we strongly advise pinning each module to the exact version
> you're using. This practice ensures the stability of your infrastructure. Additionally, we recommend implementing a systematic
> approach for updating versions to avoid unexpected changes.








<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dns"></a> [dns](#module\_dns) | cloudposse/route53-cluster-hostname/aws | 0.13.0 |
| <a name="module_instance"></a> [instance](#module\_instance) | cloudposse/ec2-instance/aws | 1.2.1 |
| <a name="module_label"></a> [label](#module\_label) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_cidr_blocks"></a> [allow\_cidr\_blocks](#input\_allow\_cidr\_blocks) | List of CIDR blocks to permit SSH access | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes (e.g. `policy` or `role`) | `list(string)` | `[]` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between `name`, `namespace`, `stage`, etc. | `string` | `"-"` | no |
| <a name="input_dns_ttl"></a> [dns\_ttl](#input\_dns\_ttl) | The time for which a DNS resolver caches a response | `string` | `"60"` | no |
| <a name="input_ec2_ami"></a> [ec2\_ami](#input\_ec2\_ami) | By default it is an AMI provided by Amazon with Ubuntu 16.04 | `string` | `"ami-cd0f5cb6"` | no |
| <a name="input_github_api_token"></a> [github\_api\_token](#input\_github\_api\_token) | GitHub API token | `any` | n/a | yes |
| <a name="input_github_organization"></a> [github\_organization](#input\_github\_organization) | GitHub organization name | `any` | n/a | yes |
| <a name="input_github_team"></a> [github\_team](#input\_github\_team) | GitHub team | `any` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of instance that will be created (e.g. `t2.micro`) | `string` | `"t2.micro"` | no |
| <a name="input_name"></a> [name](#input\_name) | The Name of the application or solution  (e.g. `bastion` or `portal`) | `any` | n/a | yes |
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







## Related Projects

Check out these related projects.

- [bastion](https://github.com/cloudposse/bastion) - 🔒Secure Bastion implemented as Docker Container running Alpine Linux with Google Authenticator & DUO MFA support
- [terraform-aws-ec2-bastion-server](https://github.com/cloudposse/terraform-aws-ec2-bastion-server) - Terraform Module to define a generic Bastion host with parameterized user_data
- [terraform-aws-ec2-instance](https://github.com/cloudposse/terraform-aws-ec2-instance) - Terraform Module for providing a general EC2 instance provisioned by Ansible


## References

For additional context, refer to some of these links.

- [terraform-aws-ec2-bastion-server](https://github.com/cloudposse/terraform-aws-ec2-bastion-server) - Thanks for the inspiration



> [!TIP]
> #### Use Terraform Reference Architectures for AWS
>
> Use Cloud Posse's ready-to-go [terraform architecture blueprints](https://cloudposse.com/reference-architecture/) for AWS to get up and running quickly.
>
> ✅ We build it together with your team.<br/>
> ✅ Your team owns everything.<br/>
> ✅ 100% Open Source and backed by fanatical support.<br/>
>
> <a href="https://cpco.io/commercial-support?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ec2-admin-server&utm_content=commercial_support"><img alt="Request Quote" src="https://img.shields.io/badge/request%20quote-success.svg?style=for-the-badge"/></a>
> <details><summary>📚 <strong>Learn More</strong></summary>
>
> <br/>
>
> Cloud Posse is the leading [**DevOps Accelerator**](https://cpco.io/commercial-support?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ec2-admin-server&utm_content=commercial_support) for funded startups and enterprises.
>
> *Your team can operate like a pro today.*
>
> Ensure that your team succeeds by using Cloud Posse's proven process and turnkey blueprints. Plus, we stick around until you succeed.
> #### Day-0:  Your Foundation for Success
> - **Reference Architecture.** You'll get everything you need from the ground up built using 100% infrastructure as code.
> - **Deployment Strategy.** Adopt a proven deployment strategy with GitHub Actions, enabling automated, repeatable, and reliable software releases.
> - **Site Reliability Engineering.** Gain total visibility into your applications and services with Datadog, ensuring high availability and performance.
> - **Security Baseline.** Establish a secure environment from the start, with built-in governance, accountability, and comprehensive audit logs, safeguarding your operations.
> - **GitOps.** Empower your team to manage infrastructure changes confidently and efficiently through Pull Requests, leveraging the full power of GitHub Actions.
>
> <a href="https://cpco.io/commercial-support?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ec2-admin-server&utm_content=commercial_support"><img alt="Request Quote" src="https://img.shields.io/badge/request%20quote-success.svg?style=for-the-badge"/></a>
>
> #### Day-2: Your Operational Mastery
> - **Training.** Equip your team with the knowledge and skills to confidently manage the infrastructure, ensuring long-term success and self-sufficiency.
> - **Support.** Benefit from a seamless communication over Slack with our experts, ensuring you have the support you need, whenever you need it.
> - **Troubleshooting.** Access expert assistance to quickly resolve any operational challenges, minimizing downtime and maintaining business continuity.
> - **Code Reviews.** Enhance your team’s code quality with our expert feedback, fostering continuous improvement and collaboration.
> - **Bug Fixes.** Rely on our team to troubleshoot and resolve any issues, ensuring your systems run smoothly.
> - **Migration Assistance.** Accelerate your migration process with our dedicated support, minimizing disruption and speeding up time-to-value.
> - **Customer Workshops.** Engage with our team in weekly workshops, gaining insights and strategies to continuously improve and innovate.
>
> <a href="https://cpco.io/commercial-support?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ec2-admin-server&utm_content=commercial_support"><img alt="Request Quote" src="https://img.shields.io/badge/request%20quote-success.svg?style=for-the-badge"/></a>
> </details>

## ✨ Contributing

This project is under active development, and we encourage contributions from our community.



Many thanks to our outstanding contributors:

<a href="https://github.com/cloudposse/terraform-aws-ec2-admin-server/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=cloudposse/terraform-aws-ec2-admin-server&max=24" />
</a>

For 🐛 bug reports & feature requests, please use the [issue tracker](https://github.com/cloudposse/terraform-aws-ec2-admin-server/issues).

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.
 1. Review our [Code of Conduct](https://github.com/cloudposse/terraform-aws-ec2-admin-server/?tab=coc-ov-file#code-of-conduct) and [Contributor Guidelines](https://github.com/cloudposse/.github/blob/main/CONTRIBUTING.md).
 2. **Fork** the repo on GitHub
 3. **Clone** the project to your own machine
 4. **Commit** changes to your own branch
 5. **Push** your work back up to your fork
 6. Submit a **Pull Request** so that we can review your changes

**NOTE:** Be sure to merge the latest changes from "upstream" before making a pull request!

### 🌎 Slack Community

Join our [Open Source Community](https://cpco.io/slack?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ec2-admin-server&utm_content=slack) on Slack. It's **FREE** for everyone! Our "SweetOps" community is where you get to talk with others who share a similar vision for how to rollout and manage infrastructure. This is the best place to talk shop, ask questions, solicit feedback, and work together as a community to build totally *sweet* infrastructure.

### 📰 Newsletter

Sign up for [our newsletter](https://cpco.io/newsletter?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ec2-admin-server&utm_content=newsletter) and join 3,000+ DevOps engineers, CTOs, and founders who get insider access to the latest DevOps trends, so you can always stay in the know.
Dropped straight into your Inbox every week — and usually a 5-minute read.

### 📆 Office Hours <a href="https://cloudposse.com/office-hours?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ec2-admin-server&utm_content=office_hours"><img src="https://img.cloudposse.com/fit-in/200x200/https://cloudposse.com/wp-content/uploads/2019/08/Powered-by-Zoom.png" align="right" /></a>

[Join us every Wednesday via Zoom](https://cloudposse.com/office-hours?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ec2-admin-server&utm_content=office_hours) for your weekly dose of insider DevOps trends, AWS news and Terraform insights, all sourced from our SweetOps community, plus a _live Q&A_ that you can’t find anywhere else.
It's **FREE** for everyone!
## License

<a href="https://opensource.org/licenses/Apache-2.0"><img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg?style=for-the-badge" alt="License"></a>

<details>
<summary>Preamble to the Apache License, Version 2.0</summary>
<br/>
<br/>

Complete license is available in the [`LICENSE`](LICENSE) file.

```text
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
```
</details>

## Trademarks

All other trademarks referenced herein are the property of their respective owners.


---
Copyright © 2017-2025 [Cloud Posse, LLC](https://cpco.io/copyright)


<a href="https://cloudposse.com/readme/footer/link?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-ec2-admin-server&utm_content=readme_footer_link"><img alt="README footer" src="https://cloudposse.com/readme/footer/img"/></a>

<img alt="Beacon" width="0" src="https://ga-beacon.cloudposse.com/UA-76589703-4/cloudposse/terraform-aws-ec2-admin-server?pixel&cs=github&cm=readme&an=terraform-aws-ec2-admin-server"/>
