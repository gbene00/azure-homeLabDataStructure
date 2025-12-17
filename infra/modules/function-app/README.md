# function-app module

Creates:
- Runtime Storage Account for Functions (AzureWebJobsStorage)
- Linux Consumption Service Plan
- Linux Function App (Python) with SystemAssigned identity
- RBAC: Storage Blob Data Contributor on the DATA storage account

Inputs:
- docint endpoint + key
- app insights connection string
- data storage account id/name + container names
