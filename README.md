# Despliegue de una Aplicación Node.js en Azure usando GitHub Actions

## Introducción

Este proyecto guía a través del proceso de despliegue de una aplicación Node.js en Azure App Service, utilizando GitHub Actions para automatizar el flujo de trabajo. Este enfoque asegura que cada vez que se realicen cambios en el código, la aplicación se despliegue de manera eficiente y sin intervención manual.

## Direcciones a los diferentes ambientes

Production: https://webapppocfranc-appservice.azurewebsites.net/
Qa: https://webapppocfranc-appservice-qa.azurewebsites.net/

## Requisitos Previos

- **Cuenta de Azure**: Con permisos para crear y gestionar recursos.
- **Proyecto Node.js**: Con un archivo `index.js` como punto de entrada.
- **Cuenta github**: Repo donde se almacena el código fuente "WEBAPPPOC"
- **Configuración de secretos en GitHub**: Para la autenticación con Azure.

## Configuración de Azure

### Crear un Service principal, Resource Group y una Storage Account

Dentro de la carpeta `script-tools` se encuentra los siguiente script de Bash 

- **`azure-poc-franco`** Este script se ejecuta para crean un service principal en la cuenta de azure el cual sirve para registrar la aplicacion y poder realizar modificacion en azure (tener presente que la cuenta desde donde se ejecuta debe tener permisos de colaborar, de lo contario no va a funcionar) 
tener presente que este scrip nos devuelve un json que es necesario para configurar la varialbe en github AZURE_CREDENTIALS

- **`storage-tfstate-creeated`** este se ejecuta y permite crear un grupo de recursos, una cuenta de almacenamiento y un contenedor de blobs para almacenar el estado de Terraform, el cual puede ser de acceso para los usuarios que participen del proceso de despliegue de la infraestructura necesaria para que funcione la webapp de azure


# Configurar Terraform
Para configurar Terraform, sigue estos pasos:

`Configura el Backend en Azure`: Terraform necesita almacenar su estado en un backend para gestionar la infraestructura. En este caso, se utilizará un backend en Azure. Debes configurar el archivo main.tf en la carpeta infra para que apunte al almacenamiento adecuado.

`Modificar el archivo main.tf`: En la carpeta infra, abre el archivo main.tf y asegúrate de que contenga la configuración para el backend en Azure. Aquí se especifica cómo Terraform debe almacenar el estado de la infraestructura. A continuación, se muestra un ejemplo de configuración:

    resource_group_name   = "tfstate-resources-franco1"
    storage_account_name  = "tfstatedpocfran1"
    container_name        = "tfstate-franco1"
    key                   = "terraform.tfstate"

- **resource_group_name**: El nombre del grupo de recursos en Azure que contiene el almacenamiento.
- **storage_account_name**: El nombre de la cuenta de almacenamiento en Azure.
- **container_name**: El nombre del contenedor dentro de la cuenta de almacenamiento.
- **key**: El nombre del archivo de estado que Terraform utilizará.
# Deploy de la infrastructura

- **`deploy-app.yml`** 

El archivo `deploy-infrastructure.yml` contiene la configuración para desplegar los diferentes recursos necesarios en Azure para que la aplicación funcione correctamente. Este despliegue está configurado para ejecutarse de forma manual, evitando que se ejecute automáticamente en cada push a la rama main.

Es importante asegurarse de que la variable AZURE_CREDENTIALS esté configurada correctamente en los secretos de GitHub, utilizando el archivo JSON del Service Principal, para que el despliegue funcione sin problemas.


# Deploy de la aplicacion

- **`deploy-app.yml`** 

El archivo deploy-app.yml define el flujo de trabajo para desplegar la aplicación en Azure App Service. Contiene una serie de trabajos (jobs) que son necesarios para garantizar que la aplicación funcione correctamente en el entorno de Azure.

Este flujo de trabajo se activa automáticamente cada vez que se realiza un push a la rama main del repositorio. GitHub Actions ejecuta los pasos necesarios, como la instalación de dependencias, la construcción del proyecto y finalmente, el despliegue de la aplicación en Azure.

## Ambiente QA

Además del entorno de producción, esta aplicación cuenta con un ambiente de pruebas que se encuentra en el slot QA dentro del mismo Azure App Service.

Despliegue en QA: Para desplegar en este ambiente, simplemente realiza modificaciones en la rama QA del repositorio en GitHub, y el flujo de trabajo se encargará de desplegar la versión en dicho slot.











