## Resource Group
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.tags
}

## Storage module (data storage + containers + blob properties)
module "storage" {
  source = "../infra/modules/storage"

  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  tags                = local.tags

  data_storage_account_name   = var.data_storage_account_name
  raw_container_name          = var.raw_container_name
  processed_container_name    = var.processed_container_name
  enable_blob_versioning      = var.enable_blob_versioning
  soft_delete_retention_days  = var.soft_delete_retention_days
}

## Monitoring module (Log Analytics + Application Insights)
module "monitoring" {
  source = "../infra/modules/monitoring"

  resource_group_name          = azurerm_resource_group.resource_group.name
  location                     = azurerm_resource_group.resource_group.location
  tags                         = local.tags
  log_analytics_name           = var.log_analytics_name
  log_analytics_retention_days = var.log_analytics_retention_days
  app_insights_name            = var.app_insights_name
}

## Document Intelligence module
module "docu_intelligence" {
  source = "../infra/modules/docu-intelligence"

  resource_group_name        = azurerm_resource_group.resource_group.name
  location                   = azurerm_resource_group.resource_group.location
  tags                       = local.tags
  document_intelligence_name = var.document_intelligence_name
}

## Function App module (plan + function app + RBAC)
module "function_app" {
  source = "../infra/modules/function-app"

  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  tags                = local.tags

  function_plan_name = var.function_plan_name
  function_app_name  = var.function_app_name

  runtime_storage_account_name = var.runtime_storage_account_name

  ## Runtime Storage connection (used by Functions runtime AzureWebJobsStorage)
  runtime_storage_connection_string = module.function_app.runtime_storage_connection_string

  ## Data storage information
  data_storage_account_id   = module.storage.data_storage_account_id
  data_storage_account_name = module.storage.data_storage_account_name
  raw_container_name        = module.storage.raw_container_name
  processed_container_name  = module.storage.processed_container_name

  ## External integrations
  docint_endpoint = module.docu_intelligence.docint_endpoint
  docint_key      = module.docu_intelligence.docint_key

  app_insights_connection_string = module.monitoring.app_insights_connection_string

  ## Base settings from locals
  function_app_settings_base = local.function_app_settings

  depends_on = [
    module.monitoring,
    module.storage,
    module.docu_intelligence
  ]
}

## Static Web App module
module "static_web_app" {
  source = "../infra/modules/static-web-app"

  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  tags                = local.tags

  static_web_app_name = var.static_web_app_name
}
