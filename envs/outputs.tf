output "resource_group_name" {
  value = azurerm_resource_group.resource_group.name
}

output "data_storage_account_name" {
  value = azurerm_storage_account.storage_account.name
}

output "raw_container_name" {
  value = azurerm_storage_container.blob_raw.name
}

output "processed_container_name" {
  value = azurerm_storage_container.blob_processed.name
}

output "runtime_storage_account_name" {
  value = azurerm_storage_account.runtime_storage.name
}

output "function_app_name" {
  value = azurerm_linux_function_app.function_app.name
}

output "function_hostname" {
  value = azurerm_linux_function_app.function_app.default_hostname
}

output "docint_endpoint" {
  value = azurerm_cognitive_account.cognitive_account.endpoint
}

output "static_web_app_default_hostname" {
  value = azurerm_static_site.static_web_app.default_host_name
}

output "static_web_app_api_key" {
  value     = azurerm_static_site.static_web_app.api_key
  sensitive = true
}

output "app_insights_connection_string" {
  value     = azurerm_application_insights.insights.connection_string
  sensitive = true
}
