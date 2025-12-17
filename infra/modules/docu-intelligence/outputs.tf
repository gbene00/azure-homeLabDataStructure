output "docint_endpoint" {
  value = azurerm_cognitive_account.cognitive_account.endpoint
}

output "docint_key" {
  value     = azurerm_cognitive_account.cognitive_account.primary_access_key
  sensitive = true
}
