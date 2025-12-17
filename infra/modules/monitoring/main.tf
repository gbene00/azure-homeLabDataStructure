## Azure Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "law" {
  name                = var.log_analytics_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"

  retention_in_days = var.log_analytics_retention_days

  tags = var.tags
}

## Azure Application Insights (workspace-based)
resource "azurerm_application_insights" "insights" {
  name                = var.app_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"

  workspace_id = azurerm_log_analytics_workspace.law.id

  tags = var.tags
}
