#!/bin/bash

# Variables
RESOURCE_GROUP_NAME="tfstate-resources-franco"
STORAGE_ACCOUNT_NAME="tfstatedpocfran"  # Debe ser único a nivel global
CONTAINER_NAME="tfstate-franco"
TAGS="Owner=Pod2 CreatedBy=FrancoGaloppo Project=labs Pod=2 Deadline=SERVICIOS"

# Login to Azure
az login

# Create resource group for storage account
az group create --name $RESOURCE_GROUP_NAME --location eastus --tags $TAGS

# Create storage account
az storage account create --name $STORAGE_ACCOUNT_NAME --resource-group $RESOURCE_GROUP_NAME --location eastus --sku Standard_LRS --tags $TAGS

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' --output tsv)

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY

# Output the storage account details
echo "storage_account_name: $STORAGE_ACCOUNT_NAME"
echo "container_name: $CONTAINER_NAME"
echo "access_key: $ACCOUNT_KEY"
