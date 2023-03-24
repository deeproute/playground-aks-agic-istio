data "azurerm_kubernetes_cluster" "this" {
  name                = module.aks.name
  resource_group_name = var.resource_group_name

  depends_on = [
    module.aks
  ]
}

# AGIC Managed Identity created by AKS Infra Resource group
data "azurerm_user_assigned_identity" "appgw_agic_identity" { 
  name = "ingressapplicationgateway-${module.aks.name}"
  resource_group_name = module.aks.infra_resource_group

  depends_on = [
    module.aks
  ]
}