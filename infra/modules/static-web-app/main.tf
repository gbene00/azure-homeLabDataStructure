## Static Web App
resource "azurerm_static_web_app" "static_web_app" {
  name                = var.static_web_app_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku_tier = "Free"
  sku_size = "Free"

  tags = var.tags
}
