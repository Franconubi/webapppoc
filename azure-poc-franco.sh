
#!/bin/bash

# Variables
AZURE_SUBSCRIPTION_ID="f6dbe5ba-5b80-4470-a15d-606190555276"
AZURE_RESOURCE_GROUP="webappspoc-franc"
AZURE_SERVICE_PRINCIPAL_NAME="webappspoc-franc"
TAGS="createdby='Franco Galoppo' Environment='Testing' owner='Pod2' ProyectType='labs' AREA='Servicios'"

# Create the resource group if it doesn't exist
az group create --name $AZURE_RESOURCE_GROUP --location eastus --tags $TAGS

# Create the service principal
SERVICE_PRINCIPAL=$(az ad sp create-for-rbac --name $AZURE_SERVICE_PRINCIPAL_NAME --role contributor --scopes /subscriptions/$AZURE_SUBSCRIPTION_ID/resourceGroups/$AZURE_RESOURCE_GROUP --sdk-auth)

# Check if the service principal was created successfully
if [ $? -eq 0 ]; then
  echo "Service principal created successfully."
  echo $SERVICE_PRINCIPAL
else
  echo "Failed to create service principal."
  exit 1
fi

# Apply tags to the service principal (if needed)
# Note: Azure AD service principals do not directly support tags. You can apply tags to the resources they create instead.

# Example to apply tags to a specific resource (replace with actual resource details)
# az resource tag --resource-group $AZURE_RESOURCE_GROUP --name <resource-name> --resource-type <resource-type> --tags $TAGS

echo "Script executed successfully."
