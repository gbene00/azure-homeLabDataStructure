output "runtime_storage_account_name" {
  value = azurerm_storage_account.runtime_storage.name
}

output "runtime_storage_connection_string" {
  value     = azurerm_storage_account.runtime_storage.primary_connection_string
  sensitive = true
}

output "function_app_name" {
  value = azurerm_linux_function_app.function_app.name
}

output "function_hostname" {
  value = azurerm_linux_function_app.function_app.default_hostname
}
