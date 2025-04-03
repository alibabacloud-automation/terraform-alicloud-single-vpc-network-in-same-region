resource "alicloud_vpc" "this" {
  vpc_name          = var.vpc_config.vpc_name
  cidr_block        = var.vpc_config.cidr_block
  description       = var.vpc_config.description
  resource_group_id = var.resource_group_id
  tags              = var.tags
}

locals {
  public_vswitch_type = ["slb", "nat", "application"]
  public_vswitches = {
    for item in flatten([
      for i, zone_id in var.zone_id : [
        for j, type in local.public_vswitch_type : {
          id           = "${type}-${tonumber(i + 1)}"
          vswitch_name = "public-${type}-${tonumber(i + 1)}"
          zone_id      = zone_id
          cidr_block   = cidrsubnet(var.vpc_config.cidr_block, 8, length(var.zone_id) * tonumber(j) + tonumber(i + 1))
        }
      ]
    ]) : item.id => item
  }

  private_vswitch_type = ["application", "tr", "slb"]
  private_vswitches = {
    for item in flatten([
      for i, zone_id in var.zone_id : [
        for j, type in local.private_vswitch_type : {
          id           = "${type}-${tonumber(i + 1)}"
          vswitch_name = "private-${type}-${tonumber(i + 1)}"
          zone_id      = zone_id
          cidr_block   = cidrsubnet(var.vpc_config.cidr_block, 8, length(var.zone_id) * tonumber(j) + tonumber(i + 7))
        }
      ]
    ]) : item.id => item
  }
}

resource "alicloud_vswitch" "public" {
  for_each = local.public_vswitches

  vpc_id       = alicloud_vpc.this.id
  cidr_block   = each.value.cidr_block
  zone_id      = each.value.zone_id
  vswitch_name = each.value.vswitch_name
  tags         = var.tags
}

resource "alicloud_vswitch" "private" {
  for_each = local.private_vswitches

  vpc_id       = alicloud_vpc.this.id
  cidr_block   = each.value.cidr_block
  zone_id      = each.value.zone_id
  vswitch_name = each.value.vswitch_name
  tags         = var.tags
}

# ipv4_gateway
resource "alicloud_vpc_ipv4_gateway" "this" {
  ipv4_gateway_name        = var.ipv4_gateway.ipv4_gateway_name
  ipv4_gateway_description = var.ipv4_gateway.ipv4_gateway_description
  vpc_id                   = alicloud_vpc.this.id
  enabled                  = var.ipv4_gateway.enabled
  resource_group_id        = var.resource_group_id
  tags                     = var.tags
}

resource "alicloud_route_table" "ipv4_gateway" {
  vpc_id           = alicloud_vpc.this.id
  route_table_name = var.ipv4_gateway.route_table_name
  description      = var.ipv4_gateway.route_table_description
  associate_type   = "Gateway"
  tags             = var.tags
}

resource "alicloud_vpc_gateway_route_table_attachment" "this" {
  ipv4_gateway_id = alicloud_vpc_ipv4_gateway.this.id
  route_table_id  = alicloud_route_table.ipv4_gateway.id
}


# EIP
resource "alicloud_eip_address" "this" {
  address_name      = var.eip_address_config.address_name
  bandwidth         = var.eip_address_config.bandwidth
  tags              = var.tags
  resource_group_id = var.resource_group_id
}

# NAT_GW
resource "alicloud_nat_gateway" "this" {
  vpc_id           = alicloud_vpc.this.id
  nat_gateway_name = var.nat_gateway.nat_gateway_name
  payment_type     = var.nat_gateway.payment_type
  vswitch_id       = alicloud_vswitch.public["nat-1"].id
  nat_type         = var.nat_gateway.nat_type
  network_type     = var.nat_gateway.network_type
  eip_bind_mode    = "NAT"
  tags             = var.tags
}

resource "alicloud_eip_association" "this" {
  allocation_id = alicloud_eip_address.this.id
  instance_id   = alicloud_nat_gateway.this.id
}

resource "alicloud_snat_entry" "this" {
  for_each = { for vsw in ["nat-1", "nat-2"] : vsw => alicloud_vswitch.public[vsw].id }

  snat_table_id     = alicloud_nat_gateway.this.snat_table_ids
  source_vswitch_id = each.value
  snat_ip           = alicloud_eip_address.this.ip_address
}

locals {
  default_route_table_vsw_list = ["nat-1", "nat-2", "slb-1", "slb-2"]
  route_table_1_vsw_list       = ["application-1", "application-2"]
}


# default_route_table
resource "alicloud_route_table_attachment" "default_route_table" {
  for_each = { for key in local.default_route_table_vsw_list : key => key }

  vswitch_id     = alicloud_vswitch.public[each.key].id
  route_table_id = alicloud_vpc.this.route_table_id
}

resource "alicloud_route_entry" "default_route_table" {
  route_table_id        = alicloud_vpc.this.route_table_id
  destination_cidrblock = "0.0.0.0/0"
  nexthop_type          = "Ipv4Gateway"
  nexthop_id            = alicloud_vpc_ipv4_gateway.this.id
  name                  = "Ipv4Gateway"
}


# route_table_1
resource "alicloud_route_table" "this_1" {
  vpc_id           = alicloud_vpc.this.id
  route_table_name = "route-table-1"
  associate_type   = "VSwitch"
  tags             = var.tags
}

resource "alicloud_route_table_attachment" "route_table_1" {
  for_each = { for key in local.route_table_1_vsw_list : key => key }

  vswitch_id     = alicloud_vswitch.public[each.key].id
  route_table_id = alicloud_route_table.this_1.id
}

resource "alicloud_route_entry" "route_table_1" {
  route_table_id        = alicloud_route_table.this_1.id
  destination_cidrblock = "0.0.0.0/0"
  nexthop_type          = "NatGateway"
  nexthop_id            = alicloud_nat_gateway.this.id
  name                  = "NatGateway"
}


# route_table_2
resource "alicloud_route_table" "this_2" {
  vpc_id           = alicloud_vpc.this.id
  route_table_name = "route-table-2"
  associate_type   = "VSwitch"
  tags             = var.tags
}

resource "alicloud_route_table_attachment" "route_table_2" {
  for_each = alicloud_vswitch.private

  vswitch_id     = each.value.id
  route_table_id = alicloud_route_table.this_2.id
}

locals {
  alb_vsw_list = ["slb-1", "slb-2"]
}

# ALB
resource "alicloud_alb_load_balancer" "internet" {
  vpc_id                 = alicloud_vpc.this.id
  address_type           = "Internet"
  address_allocated_mode = var.internet_alb_config.address_allocated_mode
  load_balancer_name     = "internet-alb"
  load_balancer_edition  = var.internet_alb_config.load_balancer_edition
  tags                   = var.tags
  load_balancer_billing_config {
    pay_type = "PayAsYouGo"
  }
  dynamic "zone_mappings" {
    for_each = { for key in local.alb_vsw_list : key => alicloud_vswitch.public[key] }
    content {
      vswitch_id = zone_mappings.value.id
      zone_id    = zone_mappings.value.zone_id
    }
  }
  modification_protection_config {
    status = var.internet_alb_config.modification_protection_config_status
    reason = var.internet_alb_config.modification_protection_config_reason
  }

  dynamic "access_log_config" {
    for_each = var.internet_alb_config.access_log_config
    content {
      log_project = access_log_config.value.log_project
      log_store   = access_log_config.value.log_store
    }
  }
}

resource "alicloud_alb_load_balancer" "intranet" {
  vpc_id                 = alicloud_vpc.this.id
  address_type           = "Intranet"
  address_allocated_mode = var.intranet_alb_config.address_allocated_mode
  load_balancer_name     = "intranet-alb"
  load_balancer_edition  = var.intranet_alb_config.load_balancer_edition
  tags                   = var.tags
  load_balancer_billing_config {
    pay_type = "PayAsYouGo"
  }
  dynamic "zone_mappings" {
    for_each = { for key in local.alb_vsw_list : key => alicloud_vswitch.private[key] }
    content {
      vswitch_id = zone_mappings.value.id
      zone_id    = zone_mappings.value.zone_id
    }
  }
  modification_protection_config {
    status = var.intranet_alb_config.modification_protection_config_status
    reason = var.intranet_alb_config.modification_protection_config_reason
  }

  dynamic "access_log_config" {
    for_each = var.intranet_alb_config.access_log_config
    content {
      log_project = access_log_config.value.log_project
      log_store   = access_log_config.value.log_store
    }
  }
}
