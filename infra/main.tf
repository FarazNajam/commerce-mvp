terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.113"
    }
  }
}

provider "azurerm" {
  features {}
}

# Use an existing Resource Group
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_service_plan" "asp" {
  name                = var.app_service_plan_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = var.sku_name
}

resource "azurerm_linux_web_app" "app" {
  name                = var.web_app_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.asp.id
  https_only          = true

  identity { type = "SystemAssigned" }

  site_config {
    application_stack {
      dotnet_version = "8.0"
    }
  }
}

output "plan_id"     { value = azurerm_service_plan.asp.id }
output "webapp_host" { value = azurerm_linux_web_app.app.default_hostname }
