variable "vpc_config" {
  description = "The parameters of vpc. The attribute 'cidr_block' is required."
  type = object({
    cidr_block  = string
    vpc_name    = optional(string, null)
    description = optional(string, null)
  })
}

variable "zone_id" {
  description = "The zone_id of VSwitches."
  type        = list(string)

  validation {
    condition     = length(var.zone_id) == 2
    error_message = "The length of zone_id must be 2."
  }
}

variable "ipv4_gateway" {
  description = "The parameters of ipv4 gateway."
  type = object({
    ipv4_gateway_name        = optional(string, null)
    ipv4_gateway_description = optional(string, null)
    enabled                  = optional(bool, true)
    route_table_name         = optional(string, null)
    route_table_description  = optional(string, null)
  })
  default = {}
}

variable "eip_address_config" {
  description = "The parameters of eip address."
  type = object({
    address_name = optional(string, null)
    bandwidth    = optional(number, 10)
  })
  default = {}
}

variable "nat_gateway" {
  description = "The parameters of nat gateway."
  type = object({
    nat_gateway_name = optional(string, null)
    payment_type     = optional(string, "PayAsYouGo")
    nat_type         = optional(string, "Enhanced")
    network_type     = optional(string, "internet")
  })
  default = {}
}

variable "internet_alb_config" {
  description = "The parameters of internet ALB."
  type = object({
    load_balancer_edition                 = optional(string, "Basic")
    address_allocated_mode                = optional(string, "Fixed")
    modification_protection_config_status = optional(string, "NonProtection")
    modification_protection_config_reason = optional(string, null)
    access_log_config = optional(list(object({
      log_project = string
      log_store   = string
    })), [])
  })
  default = {}
}

variable "intranet_alb_config" {
  description = "The parameters of internet ALB."
  type = object({
    load_balancer_edition                 = optional(string, "Basic")
    address_allocated_mode                = optional(string, "Fixed")
    modification_protection_config_status = optional(string, "NonProtection")
    modification_protection_config_reason = optional(string, null)
    access_log_config = optional(list(object({
      log_project = string
      log_store   = string
    })), [])
  })
  default = {}
}


variable "resource_group_id" {
  description = "The resource_group_id of resources."
  type        = string
  default     = null
}

variable "tags" {
  description = "The tags of resources."
  type        = map(string)
  default     = {}
}
