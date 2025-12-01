
locals {
  prefix  = "${var.project}-${var.env}"

  # Storage account names must be <= 24 chars, lowercase, alphanumeric.
  # We remove dashes and truncate to 24 just in case project-env gets long.
  sa_name = substr(
    lower("st${replace(local.prefix, "-", "")}${random_string.sa_suffix.result}"),
    0,
    24
  )
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.prefix}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${local.prefix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

resource "azurerm_subnet" "subnets" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value]
}

resource "random_string" "sa_suffix" {
  length  = 6
  upper   = false
  lower   = true
  numeric = true
  special = false
}

resource "azurerm_storage_account" "sa" {
  name                     = local.sa_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_kind             = "StorageV2"     # explicit modern kind
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  # New attribute name in AzureRM v4.x
  https_traffic_only_enabled = true

  tags = var.tags
}