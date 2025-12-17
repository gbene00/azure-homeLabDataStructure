
## Resource Group
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.tags
}

## Azure Storage Account
resource "azurerm_storage_account" "storage_account" {
  name                     = var.data_storage_account_name
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false

  tags = local.tags
}

## Azure Blob Containers
resource "azurerm_storage_container" "blob_raw" {
  name                  = var.raw_container_name
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "blob_processed" {
  name                  = var.processed_container_name
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

## Azure Storage Blob Properties (versioning + soft delete)
resource "azurerm_storage_account_blob_properties" "data_blob" {
  storage_account_id = azurerm_storage_account.storage_account.id

  versioning_enabled = var.enable_blob_versioning

  delete_retention_policy {
    days = var.soft_delete_retention_days
  }

  container_delete_retention_policy {
    days = var.soft_delete_retention_days
  }
  
  depends_on = [
    azurerm_storage_container.blob_raw,
    azurerm_storage_container.blob_processed
  ]
}

## Azure Runtime Storage Account (Functions AzureWebJobsStorage)
resource "azurerm_storage_account" "runtime_storage" {
  name                     = var.runtime_storage_account_name
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false

  tags = local.tags
}

## Azure Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "law" {
  name                = var.log_analytics_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  sku                 = "PerGB2018"

  retention_in_days = 30

  tags = local.tags
}

## Azure Application Insights
resource "azurerm_application_insights" "insights" {
  name                = var.app_insights_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  application_type    = "web"

  workspace_id = azurerm_log_analytics_workspace.law.id

  tags = local.tags
}

## Azure Cognitive Services - Document Intelligence
resource "azurerm_cognitive_account" "cognitive_account" {
  name                = var.document_intelligence_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  kind     = "FormRecognizer"
  sku_name = "S0"

  tags = local.tags
}


## Azure Function App Service Plan
resource "azurerm_service_plan" "function_plan" {
  name                = var.function_plan_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location

  os_type  = "Linux"
  sku_name = "Y1" # Consumption

  tags = local.tags
}

## Azure Function App
resource "azurerm_linux_function_app" "function_app" {
  name                = var.function_app_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location

  service_plan_id = azurerm_service_plan.function_plan.id

  ## Storage Runtime settings
  storage_account_name       = azurerm_storage_account.runtime_storage.name
  storage_account_access_key = azurerm_storage_account.runtime_storage.primary_access_key
  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      python_version = "3.11"
    }
  }

  app_settings = merge(local.function_app_settings, {
    FUNCTIONS_WORKER_RUNTIME = "python"
    WEBSITE_RUN_FROM_PACKAGE = "1"

    ## Blob trigger + internal runtime storage binding
    AzureWebJobsStorage = azurerm_storage_account.runtime_storage.primary_connection_string

    ## App config
    STORAGE_ACCOUNT     = azurerm_storage_account.storage_account.name
    RAW_CONTAINER       = azurerm_storage_container.blob_raw.name
    PROCESSED_CONTAINER = azurerm_storage_container.blob_processed.name

    DOCINT_ENDPOINT = azurerm_cognitive_account.cognitive_account.endpoint
    DOCINT_KEY      = azurerm_cognitive_account.cognitive_account.primary_access_key

    ## App Insights integration
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.insights.connection_string
  })

  tags = local.tags

  depends_on = [
    azurerm_application_insights.insights,
    azurerm_storage_account.runtime_storage,
    azurerm_storage_account.storage_account,
    azurerm_cognitive_account.cognitive_account
  ]
}

## Assign Function App Managed Identity Blob Data Contributor role on DATA storage account
resource "azurerm_role_assignment" "function_blob_contributor" {
  scope                = azurerm_storage_account.storage_account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_linux_function_app.function_app.identity[0].principal_id

  depends_on = [
    azurerm_linux_function_app.function_app
    ]
}


## Static Web App
resource "azurerm_static_site" "static_web_app" {
  name                = var.static_web_app_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location

  sku_tier = "Free"
  sku_size = "Free"

  tags = local.tags
}
