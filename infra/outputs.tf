
output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "Name of the resource group"
}

output "virtual_network_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "ID of the virtual network"
}

output "subnet_ids" {
  value       = { for k, s in azurerm_subnet.subnets : k => s.id }
  description = "Map of subnet names to subnet IDs"
}

output "storage_account_name" {
  value       = azurerm_storage_account.sa.name
  description = "Storage account name"
}

output "primary_blob_endpoint" {
  value       = azurerm_storage_account.sa.primary_blob_endpoint
  description = "Primary blob endpoint URL"
}