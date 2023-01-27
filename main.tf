resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

module "azurerm_virtual_network" {
  source   = "./modules/azurerm-virtual-network"
  #for_each = { for vnet in var.vnets : vnet.name => vnet }

  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location

  name          = var.name
  address_space = var.address_space

  subnets = var.subnets

#   depends_on = [    
#     module.existing_nsg,
#     module.existing_route_table
#   ]
}