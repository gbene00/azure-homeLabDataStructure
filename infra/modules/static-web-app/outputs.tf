output "static_web_app_default_hostname" {
  value = azurerm_static_site.static_web_app.default_host_name
}

output "static_web_app_api_key" {
  value     = azurerm_static_site.static_web_app.api_key
  sensitive = true
}
