provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "webapppocfranc-resources"
  location = "westeurope"

  tags = {
    Owner    = "Pod2"
    CreatedBy = "FrancoGaloppo"
    Project  = "labs"
    Pod      = "2"
    Deadline = "SERVICIOS"
  }
}

resource "azurerm_app_service_plan" "example" {
  name                = "webapppocfranc-appserviceplan"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Windows"
  sku {
    tier = "Basic"
    size = "B1"
  }

  tags = {
    Owner    = "Pod2"
    CreatedBy = "FrancoGaloppo"
    Project  = "labs"
    Pod      = "2"
    Deadline = "SERVICIOS"
  }
}

resource "azurerm_app_service" "example" {
  name                = "webapppocfranc-appservice"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }

  tags = {
    Owner    = "Pod2"
    CreatedBy = "FrancoGaloppo"
    Project  = "labs"
    Pod      = "2"
    Deadline = "SERVICIOS"
  }
}
