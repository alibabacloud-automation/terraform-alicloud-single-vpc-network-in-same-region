output "vpc_id" {
  value       = module.complete.vpc_id
  description = "ID of the VPC."
}

output "public_vswitches_ids" {
  value       = module.complete.public_vswitches_ids
  description = "IDs of all public vswitches."
}

output "private_vswitches_ids" {
  value       = module.complete.private_vswitches_ids
  description = "IDs of all private vswitches."
}

output "ipv4_gateway_id" {
  value       = module.complete.ipv4_gateway_id
  description = "ID of the IPv4 gateway."
}

output "ipv4_gateway_route_table_id" {
  value       = module.complete.ipv4_gateway_route_table_id
  description = "The route table ID of the IPv4 gateway."
}

output "eip_id" {
  value       = module.complete.eip_id
  description = "ID of the EIP address."
}

output "nat_gateway_id" {
  value       = module.complete.nat_gateway_id
  description = "ID of the NAT gateway."
}


output "route_table_1_id" {
  value       = module.complete.route_table_1_id
  description = "The ID of route table one."
}

output "route_table_2_id" {
  value       = module.complete.route_table_2_id
  description = "The ID of route table two."
}

output "internet_alb_load_balancer_id" {
  value       = module.complete.internet_alb_load_balancer_id
  description = "The ID of internet ALB load balancer."
}

output "intranet_alb_load_balancer_id" {
  value       = module.complete.intranet_alb_load_balancer_id
  description = "The ID of intranet ALB load balancer."
}
