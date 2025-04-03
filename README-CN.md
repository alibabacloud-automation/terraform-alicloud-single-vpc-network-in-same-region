Terraform module to build single VPC network in the same region for Alibaba Cloud

terraform-alicloud-single-vpc-network-in-same-region
======================================

[English](https://github.com/alibabacloud-automation/terraform-alicloud-single-vpc-network-in-same-region/blob/main/README.md) | 简体中文

本 Module 支持通过VPC、vSwitch、IPv4网关等产品构建云上数据中心局域网，帮助用户快速构建安全、可靠且具备弹性扩展能力的网络环境。

架构图:

![image](https://raw.githubusercontent.com/alibabacloud-automation/terraform-alicloud-single-vpc-network-in-same-region/main/scripts/diagram.png)


## 用法

```hcl
provider "alicloud" {
  region = "cn-heyuan"
}

module "complete" {
  source = "alibabacloud-automation/single-vpc-network-in-same-region/alicloud"
  vpc_config = {
    cidr_block = "10.0.0.0/16"
  }
  zone_id = ["cn-heyuan-a", "cn-heyuan-b"]
}
```

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-single-vpc-network-in-same-region/tree/main/examples/complete)


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_alb_load_balancer.internet](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/alb_load_balancer) | resource |
| [alicloud_alb_load_balancer.intranet](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/alb_load_balancer) | resource |
| [alicloud_eip_address.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/eip_address) | resource |
| [alicloud_eip_association.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/eip_association) | resource |
| [alicloud_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/nat_gateway) | resource |
| [alicloud_route_entry.default_route_table](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_entry.route_table_1](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_table.ipv4_gateway](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/route_table) | resource |
| [alicloud_route_table.this_1](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/route_table) | resource |
| [alicloud_route_table.this_2](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/route_table) | resource |
| [alicloud_route_table_attachment.default_route_table](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/route_table_attachment) | resource |
| [alicloud_route_table_attachment.route_table_1](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/route_table_attachment) | resource |
| [alicloud_route_table_attachment.route_table_2](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/route_table_attachment) | resource |
| [alicloud_snat_entry.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/snat_entry) | resource |
| [alicloud_vpc.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc_gateway_route_table_attachment.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vpc_gateway_route_table_attachment) | resource |
| [alicloud_vpc_ipv4_gateway.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vpc_ipv4_gateway) | resource |
| [alicloud_vswitch.private](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.public](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eip_address_config"></a> [eip\_address\_config](#input\_eip\_address\_config) | The parameters of eip address. | <pre>object({<br>    address_name = optional(string, null)<br>    bandwidth    = optional(number, 10)<br>  })</pre> | `{}` | no |
| <a name="input_internet_alb_config"></a> [internet\_alb\_config](#input\_internet\_alb\_config) | The parameters of internet ALB. | <pre>object({<br>    load_balancer_edition                 = optional(string, "Basic")<br>    address_allocated_mode                = optional(string, "Fixed")<br>    modification_protection_config_status = optional(string, "NonProtection")<br>    modification_protection_config_reason = optional(string, null)<br>    access_log_config = optional(list(object({<br>      log_project = string<br>      log_store   = string<br>    })), [])<br>  })</pre> | `{}` | no |
| <a name="input_intranet_alb_config"></a> [intranet\_alb\_config](#input\_intranet\_alb\_config) | The parameters of internet ALB. | <pre>object({<br>    load_balancer_edition                 = optional(string, "Basic")<br>    address_allocated_mode                = optional(string, "Fixed")<br>    modification_protection_config_status = optional(string, "NonProtection")<br>    modification_protection_config_reason = optional(string, null)<br>    access_log_config = optional(list(object({<br>      log_project = string<br>      log_store   = string<br>    })), [])<br>  })</pre> | `{}` | no |
| <a name="input_ipv4_gateway"></a> [ipv4\_gateway](#input\_ipv4\_gateway) | The parameters of ipv4 gateway. | <pre>object({<br>    ipv4_gateway_name        = optional(string, null)<br>    ipv4_gateway_description = optional(string, null)<br>    enabled                  = optional(bool, true)<br>    route_table_name         = optional(string, null)<br>    route_table_description  = optional(string, null)<br>  })</pre> | `{}` | no |
| <a name="input_nat_gateway"></a> [nat\_gateway](#input\_nat\_gateway) | The parameters of nat gateway. | <pre>object({<br>    nat_gateway_name = optional(string, null)<br>    payment_type     = optional(string, "PayAsYouGo")<br>    nat_type         = optional(string, "Enhanced")<br>    network_type     = optional(string, "internet")<br>  })</pre> | `{}` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | The resource\_group\_id of resources. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags of resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | The parameters of vpc. The attribute 'cidr\_block' is required. | <pre>object({<br>    cidr_block  = string<br>    vpc_name    = optional(string, null)<br>    description = optional(string, null)<br>  })</pre> | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | The zone\_id of VSwitches. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eip_id"></a> [eip\_id](#output\_eip\_id) | ID of the EIP address. |
| <a name="output_internet_alb_load_balancer_id"></a> [internet\_alb\_load\_balancer\_id](#output\_internet\_alb\_load\_balancer\_id) | The ID of internet ALB load balancer. |
| <a name="output_intranet_alb_load_balancer_id"></a> [intranet\_alb\_load\_balancer\_id](#output\_intranet\_alb\_load\_balancer\_id) | The ID of intranet ALB load balancer. |
| <a name="output_ipv4_gateway_id"></a> [ipv4\_gateway\_id](#output\_ipv4\_gateway\_id) | ID of the IPv4 gateway. |
| <a name="output_ipv4_gateway_route_table_id"></a> [ipv4\_gateway\_route\_table\_id](#output\_ipv4\_gateway\_route\_table\_id) | The route table ID of the IPv4 gateway. |
| <a name="output_nat_gateway_id"></a> [nat\_gateway\_id](#output\_nat\_gateway\_id) | ID of the NAT gateway. |
| <a name="output_private_vswitches_ids"></a> [private\_vswitches\_ids](#output\_private\_vswitches\_ids) | IDs of all private vswitches. |
| <a name="output_public_vswitches_ids"></a> [public\_vswitches\_ids](#output\_public\_vswitches\_ids) | IDs of all public vswitches. |
| <a name="output_route_table_1_id"></a> [route\_table\_1\_id](#output\_route\_table\_1\_id) | The ID of route table one. |
| <a name="output_route_table_2_id"></a> [route\_table\_2\_id](#output\_route\_table\_2\_id) | The ID of route table two. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of the VPC. |
<!-- END_TF_DOCS -->

## 提交问题

如果在使用该 Terraform Module 的过程中有任何问题，可以直接创建一个 [Provider Issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new)，我们将根据问题描述提供解决方案。

**注意:** 不建议在该 Module 仓库中直接提交 Issue。

## 作者

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## 许可

MIT Licensed. See LICENSE for full details.

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)
