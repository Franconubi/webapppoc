# Despliegue de una Aplicación Node.js en Azure usando GitHub Actions

## Introducción

Este proyecto guía a través del proceso de despliegue de una aplicación Node.js en Azure App Service, utilizando GitHub Actions para automatizar el flujo de trabajo. Este enfoque asegura que cada vez que se realicen cambios en el código, la aplicación se despliegue de manera eficiente y sin intervención manual.

## Requisitos Previos

- **Cuenta de Azure**: Con permisos para crear y gestionar recursos.
- **Proyecto Node.js**: Con un archivo `index.js` como punto de entrada.
- **Cuenta github**: Repo donde se almacena el código fuente "WEBAPPPOC"
- **Configuración de secretos en GitHub**: Para la autenticación con Azure.

## Configuración de Azure

### Crear un Service principal, Resource Group y una Storage Account

Dentro de la carpeta `script-tools` se encuentra los siguiente script de Bash 

- **`azure-poc-franco`** Este script se ejecuta para crean un service principal en la cuenta de azure el cual sirve para registrar la aplicacion y poder realizar modificacion en azure (tener presente que la cuenta desde donde se ejecuta debe tener permisos de colaborar, de lo contario no va a funcionar)

- **`storage-tfstate-creeated`** este se ejecuta y permite crear un grupo de recursos, una cuenta de almacenamiento y un contenedor de blobs para almacenar el estado de Terraform, el cual puede ser de acceso para los usuarios que participen del proceso de despliegue de la infraestructura necesaria para que funcione la webapp de azure






