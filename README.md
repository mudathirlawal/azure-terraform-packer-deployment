# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
The goal of this project is to create infrastructure as code (IaC) in the form of a Terraform template as well as a Packer configuration to deploy a highly available website with a load balancer, as shown in the diagram below. The infrastructure is deployed into Azure in a customizable way based on specifications provided at build time, with an eye toward scaling the application for use in a CI/CD pipeline.

![alt text](/readme-images/architecture.png)

Although we could use Azure App Service to achieve the same goal, we have adopted this approach in order to make the project suitable for use in an environment or organisation where the cost 
of PaaS is a concern. Therefore, we have used only Azure IaaS so we can control cost. Since we expect the application be a popular service, it was be deployed across multiple virtual machines.

To support this need and minimize future work, we employed Packer to create a server image, and Terraform to create a template for deploying a scalable cluster of servers with a load balancer to manage the incoming traffic. We have also adhered to security practices and ensured that our infrastructure is secure.

### Main Steps
The project consist of the following main steps:

-   Creating a Packer template
-   Creating a Terraform template
-   Deploying the infrastructure

### Getting Started
1. 



### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions


### Output


