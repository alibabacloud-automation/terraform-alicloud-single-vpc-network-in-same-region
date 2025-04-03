output "vpc_id" {
  value       = alicloud_vpc.this.id
  description = "ID of the VPC."
}

output "public_vswitches_ids" {
  value       = { for key, value in alicloud_vswitch.public : key => value.id }
  description = "IDs of all public vswitches."
}

output "private_vswitches_ids" {
  value       = { for key, value in alicloud_vswitch.private : key => value.id }
  description = "IDs of all private vswitches."
}

output "ipv4_gateway_id" {
  value       = alicloud_vpc_ipv4_gateway.this.id
  description = "ID of the IPv4 gateway."
}

output "ipv4_gateway_route_table_id" {
  value       = alicloud_route_table.ipv4_gateway.id
  description = "The route table ID of the IPv4 gateway."
}

output "eip_id" {
  value       = alicloud_eip_address.this.id
  description = "ID of the EIP address."
}

output "nat_gateway_id" {
  value       = alicloud_nat_gateway.this.id
  description = "ID of the NAT gateway."
}


output "route_table_1_id" {
  value       = alicloud_route_table.this_1.id
  description = "The ID of route table one."
}

output "route_table_2_id" {
  value       = alicloud_route_table.this_2.id
  description = "The ID of route table two."
}

output "internet_alb_load_balancer_id" {
  value       = alicloud_alb_load_balancer.internet.id
  description = "The ID of internet ALB load balancer."
}

output "intranet_alb_load_balancer_id" {
  value       = alicloud_alb_load_balancer.intranet.id
  description = "The ID of intranet ALB load balancer."
}
