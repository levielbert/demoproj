
terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.54"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }

  # Configure at init time using -backend-config
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

# random provider doesn't need explicit configuration
