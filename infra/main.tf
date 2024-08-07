terraform {
  backend "azurerm" {
    resource_group_name   = "tfstate-resources-franco"
    storage_account_name  = "tfstatedpocfran"
    container_name        = "tfstate-franco"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "webapppocfranc-resources"
  location = "eastus"
  tags = {
    Owner      = "Pod2"
    CreatedBy  = "FrancoGaloppo"
    Project    = "labs"
    Pod        = "2"
    Deadline   = "SERVICIOS"
  }
}

resource "azurerm_app_service_plan" "example" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku {
    tier     = "Basic"
    size     = "B1"
  }
  tags = {
    Owner      = "Pod2"
    CreatedBy  = "FrancoGaloppo"
    Project    = "labs"
    Pod        = "2"
    Deadline   = "SERVICIOS"
  }
}

resource "azurerm_app_service" "example" {
  name                = "webapppocfranc-appservice"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  tags = {
    Owner      = "Pod2"
    CreatedBy  = "FrancoGaloppo"
    Project    = "labs"
    Pod        = "2"
    Deadline   = "SERVICIOS"
  }
}
