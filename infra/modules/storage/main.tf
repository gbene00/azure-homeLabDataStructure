## Azure Storage Account for raw and processed data
resource "azurerm_storage_account" "storage_account" {
  name                     = var.data_storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false

  tags = var.tags
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
