### AKS User Identity
resource "azurerm_user_assigned_identity" "aks_user" {
  name                = "aks-user"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.region
}

resource "azurerm_role_assignment" "aks_user_identity_operator" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = azurerm_user_assigned_identity.aks_user.principal_id
}

# Required for Network Reads (Service Type LoadBalancer)
resource "azurerm_role_assignment" "aks_user_reader" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.aks_user.principal_id
}

# Required for RouteTable Updates
resource "azurerm_role_assignment" "aks_user_routetable_network_contrib" {
  scope                = azurerm_route_table.this.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_user.principal_id
}

# Required for Internal LB Updates
resource "azurerm_role_assignment" "aks_user_vnet_network_contrib" {
  scope                = module.network.vnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_user.principal_id
}

# Required for AGIC
resource "azurerm_role_assignment" "aks_agic_rg_identity_operator" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = data.azurerm_user_assigned_identity.appgw_agic_identity.principal_id
}

# Required for AGIC to have Reader Access to Resource Group
resource "azurerm_role_assignment" "aks_agic_rg_reader" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Reader"
  principal_id         = data.azurerm_user_assigned_identity.appgw_agic_identity.principal_id
}

# Required for AGIC to have Contributor Access to App GW
resource "azurerm_role_assignment" "aks_agic_appgw_contributor" {
  scope                = azurerm_application_gateway.appgw.id
  role_definition_name = "Contributor"
  principal_id         = data.azurerm_user_assigned_identity.appgw_agic_identity.principal_id
}
