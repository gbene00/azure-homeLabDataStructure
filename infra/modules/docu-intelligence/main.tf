## Azure Cognitive Services - Document Intelligence
resource "azurerm_cognitive_account" "cognitive_account" {
  name                = var.document_intelligence_name
  location            = var.location
  resource_group_name = var.resource_group_name

  kind     = "FormRecognizer"
  sku_name = "S0"

  tags = var.tags
}
