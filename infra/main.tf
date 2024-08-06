provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "webapppocfranc-resources"
  location = "westeurope"
}

resource "azurerm_app_service_plan" "example" {
  name                = "webapppocfranc-appserviceplan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Windows"

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "webapppocfranc-appservice"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }

  site_config {
    always_on = true
  }
}

resource "azurerm_app_service_slot" "example" {
  name                = "poc"
  location            = azurerm_app_service.example.location
  resource_group_name = azurerm_app_service.example.resource_group_name
  app_service_name    = azurerm_app_service.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id
  app_settings        = azurerm_app_service.example.app_settings

  site_config {
    always_on = true
  }
}
