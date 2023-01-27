resource "azurerm_route_table" "this" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = var.disable_bgp_route_propagation
}

resource "azurerm_route" "this" {
  for_each = { for route in var.routes : route.name => route }

  name                = each.value.name
  resource_group_name = var.resource_group_name
  route_table_name    = azurerm_route_table.this.name
  address_prefix      = each.value.address_prefix
  next_hop_type       = each.value.next_hop_type
}