terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # Backend: Azure Storage (remote state)
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-file-prod-01"
    storage_account_name = "terraformstatefileprod01"
    container_name       = "tfstate"
    key                  = "keyvault/dev.tfstate"

    # Use Entra ID + OIDC from GitHub
    use_azuread_auth = true
    use_oidc         = true
  }
}

provider "azurerm" {
  features {}
}

# Get current tenant / object IDs (from the service principal)
data "azurerm_client_config" "current" {}

# Example resource group for the Key Vault
# (You can rename this to whatever convention you like)
resource "azurerm_resource_group" "rg_kv" {
  name     = "rg-kv-dev-01"
  location = "australiaeast"
}

# Key Vault module
module "key_vault" {
  source = "./modules/key_vault"

  name                = "kv-dev-01"                      # must be globally unique
  location            = azurerm_resource_group.rg_kv.location
  resource_group_name = azurerm_resource_group.rg_kv.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
}
