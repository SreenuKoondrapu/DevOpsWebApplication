# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

#Create Resoure Group
resource "azurerm_resource_group" "webapp-rg" {
  name     = "webapp-rg"
  location = "East US"
}

#Create App Service Plan
resource "azurerm_service_plan" "webapp-asp" {
  name                = "webapp-serviceplan"
  location            = azurerm_resource_group.webapp-rg.location
  resource_group_name = azurerm_resource_group.webapp-rg.name
  os_type             = "Linux"
  sku_name            = "F1"
}
#Create Azure App Service
resource "azurerm_app_service" "devops-webapplication-asp" {
  name                = "devops-webapplication-asp"
  location            = azurerm_resource_group.webapp-rg.location
  resource_group_name = azurerm_resource_group.webapp-rg.name
  app_service_plan_id = azurerm_service_plan.webapp-asp.id
}