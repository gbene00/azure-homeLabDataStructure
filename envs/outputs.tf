output "resource_group_name" {
  value = azurerm_resource_group.resource_group.name
}

output "data_storage_account_name" {
  value = module.storage.data_storage_account_name
}

output "raw_container_name" {
  value = module.storage.raw_container_name
}

output "processed_container_name" {
  value = module.storage.processed_container_name
}

output "runtime_storage_account_name" {
  value = module.function_app.runtime_storage_account_name
}

output "function_app_name" {
  value = module.function_app.function_app_name
}

output "function_hostname" {
  value = module.function_app.function_hostname
}

output "docint_endpoint" {
  value = module.docu_intelligence.docint_endpoint
}

output "static_web_app_default_hostname" {
  value = module.static_web_app.static_web_app_default_hostname
}

output "static_web_app_api_key" {
  value     = module.static_web_app.static_web_app_api_key
  sensitive = true
}

output "app_insights_connection_string" {
  value     = module.monitoring.app_insights_connection_string
  sensitive = true
}
