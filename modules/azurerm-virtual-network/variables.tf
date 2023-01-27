variable "resource_group_name" {
  type        = string
  description = "(Required) The name the Resource Group in which to create the Virtual Network"
}

variable "resource_group_location" {
  type        = string
  description = "(Required) The Azure region in which the Resource Group should be created"
}

variable "name" {
  type = string
  description = "The name of the Virtual Network to create"
}

variable "location" {
  type = string
  description = "The location in which to create the Virtual Network"
  default = null
}

variable "address_space" {
  type = list(string)
  description = "The address space(s) used by the Virtual Network"
}

variable "subnets" {
  type = list(object({
    name             = string
    address_prefixes = list(string)

    delegation = optional(object({
      name = optional(string, null)
      service_delegation = optional(object({
        name    = optional(string, null)
        actions = optional(list(string), null)
      }), null)
    }), null)

    private_endpoint_network_policies_enabled     = optional(bool, true)
    private_link_service_network_policies_enabled = optional(bool, true)

    service_endpoints           = optional(list(string), null)
    service_endpoint_policy_ids = optional(list(string), null)

    nsgs = optional(list(object({
      name = string
      rules = optional(list(object({
        name                       = string
        priority                   = string
        direction                  = string
        access                     = string
        protocol                   = string
        source_port_range          = string
        destination_port_range     = string
        source_address_prefix      = string
        destination_address_prefix = string
      })), null)
    })), [])

    nsg_ids = optional(list(string), [])

    route_tables = optional(list(object({
      name                          = string
      disable_bgp_route_propagation = optional(bool, false)

      routes = optional(list(object({
        name           = string
        address_prefix = optional(string)
        next_hop_type  = optional(string)
      })), [])
    })), [])

    route_table_ids = optional(list(string), [])

  }))
  description = "The definitions of the Subnets that the Virtual Network should contain"
}

variable "dns_servers" {
  type        = list(string)
  description = "(Optional) List of IP addresses of DNS servers"
  default     = []
}

variable "ddos_protection_plan" {
  type = object({
    enable = bool
    id     = string
  })
  description = "(Optional) Enables a DDoS Protection Plan on the Virtual Network"
  default = {
    enable = false
    id     = null
  }
}

variable "edge_zone" {
  type        = string
  description = "(Optional) The Edge Zone within the Azure Region where this Virtual Network should exist"
  default     = null
}

variable "flow_timeout_in_minutes" {
  type        = number
  description = "(Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "(Optional) The list of tags to apply to the resources"
  default     = {}
}