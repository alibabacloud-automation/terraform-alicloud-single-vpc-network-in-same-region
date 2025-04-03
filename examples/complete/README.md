
# Complete

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_complete"></a> [complete](#module\_complete) | ../.. | n/a |

## Resources

No resources.

## Inputs

No inputs.

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