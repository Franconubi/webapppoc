provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "webappspoc-franc"  # Reemplaza "myResourceGroup" con el nombre deseado para tu grupo de recursos
  location = "East US"  # Reemplaza "East US" con la región deseada
}

resource "azurerm_storage_account" "sa" {
  name                     = "webappspoc-franc"  # Reemplaza "mystorageacct" con un nombre único para la cuenta de almacenamiento
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "terraform-state-fg"  # Reemplaza "terraform-state" si deseas un nombre diferente para el contenedor
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource "azurerm_app_service_plan" "asp" {
  name                = "webappspoc-franc"  # Reemplaza "myAppServicePlan" con el nombre deseado para el plan de servicio
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Free"  # Mantén "Free" para evitar costos, ya que es un ejercicio de prueba
    size = "F1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "webappspoc-franc"  # Reemplaza "myAppService" con el nombre deseado para la aplicación web
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    app_command_line = "npm start"  # Reemplaza "npm start" con el comando que tu aplicación necesita para iniciar
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }

  depends_on = [
    azurerm_app_service_plan.asp
  ]
}

output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "storage_account_primary_access_key" {
  value = azurerm_storage_account.sa.primary_access_key
}
