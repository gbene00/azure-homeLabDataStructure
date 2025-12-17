## Azure Runtime Storage Account (Functions AzureWebJobsStorage)
resource "azurerm_storage_account" "runtime_storage" {
  name                     = var.runtime_storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false

  tags = var.tags
}

## Azure Function App Service Plan
resource "azurerm_service_plan" "function_plan" {
  name                = var.function_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location

  os_type  = "Linux"
  sku_name = "Y1" # Consumption Tier

  tags = var.tags
}

## Azure Function App
resource "azurerm_linux_function_app" "function_app" {
  name                = var.function_app_name
  resource_group_name = var.resource_group_name
  location            = var.location

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

  app_settings = merge(var.function_app_settings_base, {
    ## Blob trigger and internal runtime storage binding
    AzureWebJobsStorage = azurerm_storage_account.runtime_storage.primary_connection_string

    ## App config
    STORAGE_ACCOUNT     = var.data_storage_account_name
    RAW_CONTAINER       = var.raw_container_name
    PROCESSED_CONTAINER = var.processed_container_name

    DOCINT_ENDPOINT = var.docint_endpoint
    DOCINT_KEY      = var.docint_key

    ## App Insights integration
    APPLICATIONINSIGHTS_CONNECTION_STRING = var.app_insights_connection_string
  })

  tags = var.tags

  depends_on = [
    azurerm_storage_account.runtime_storage
  ]
}

## Azure Role Assignment: Storage Blob Data Contributor for Function App to Data Storage Account
resource "azurerm_role_assignment" "function_blob_contributor" {
  scope                = var.data_storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_linux_function_app.function_app.identity[0].principal_id

  depends_on = [
    azurerm_linux_function_app.function_app
  ]
}
