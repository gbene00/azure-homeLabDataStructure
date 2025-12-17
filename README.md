# Azure HomeLab: Data Structuring Pipeline

Purpose:
- Upload unstructured files (PDF/DOCX/etc.) via a small web UI
- Store inputs in Azure Blob Storage (raw)
- Automatically process new files with Azure Functions + Azure Document Intelligence
- Store structured results in Blob Storage (processed) as JSON
- Monitor execution using App Insights + Log Analytics
- Provision everything using Terraform

Key Azure services:
- Storage Account (raw + processed containers)
- Azure Functions (Consumption)
- Azure AI Document Intelligence
- Azure Static Web App (Free)
- Log Analytics + Application Insights
