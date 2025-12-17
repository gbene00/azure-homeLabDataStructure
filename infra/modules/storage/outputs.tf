output "data_storage_account_id" {
  value = azurerm_storage_account.storage_account.id
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
