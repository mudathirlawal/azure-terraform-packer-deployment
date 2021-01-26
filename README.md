# Azure Infrastructure Operations: Deploying a scalable IaaS web server in Azure

## Introduction
The goal of this project is to create infrastructure as code (IaC) in the form of a Terraform template as well as a Packer configuration to deploy a highly available website with a load balancer, as shown in the diagram below. The infrastructure is deployed into Azure in a customizable way based on specifications provided at build time, with an eye toward scaling the application for use in a CI/CD pipeline.

![Diagram dipicting the cloud architecture adopted.](/readme-images/architecture.png)

Although we could use Azure App Service to achieve the same goal, we have adopted this approach in order to make the project suitable for use in an environment or organisation where the cost 
of PaaS is a concern. Therefore, we have used only Azure IaaS so we can control cost. Since we expect the application be a popular service, it was deployed across multiple virtual machines.

To support this need and minimize future work, we employed Packer to create a server image, and Terraform to create a template for deploying a scalable cluster of servers with a load balancer to manage the incoming traffic. We have also adhered to security practices and ensured that our infrastructure is secure.

### Main Steps
The project consist of the following main steps:

-   Creating a Packer template
-   Creating a Terraform template
-   Deploying the infrastructure

## Getting Started

  ### Prepare the dependencies:

  1. Create an [Azure Account](https://portal.azure.com) 
  2. Install the [Azure Client/Command-Line Interface (CLI)](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
  3. Install [Packer](https://www.packer.io/downloads)
  4. Install [Terraform](https://www.terraform.io/downloads.html)

  ### Instructions

  1. [On GitHub,](https://github.com) fork the repository https://github.com/mudathirlawal/azure-terraform-packer-iac into your [GitHub account.](https://github.com)

  2. In the Cloud Shell, clone the forked repository using `git clone`. As in:

    ```bash
    git clone https://github.com/<your-alias>/azure-terraform-packer-iac.git
    Replace <your-alias> with the name of the GitHub account you used to fork the repository.
    ```

  3 Build the project following the guide provided in the links below:

  - [Build Ubuntu server image with packer](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/build-image-with-packer) 
  - [Deploy Infrastructure as Code using Terraform](https://microsoft.github.io/AzureTipsAndTricks/blog/tip201.html)
  - [Learn some Terraform](https://learn.hashicorp.com/tutorials/packer/getting-started-install)   
    
### Output

1. Packer build output should be similar to this:

  ```bash
  ==> azure-arm: Cleanup requested, deleting resource group ...
  ==> azure-arm: Resource group has been deleted.
  Build 'azure-arm' finished after 1 hour 19 minutes.

  ==> Wait completed after 1 hour 19 minutes

  ==> Builds finished. The artifacts of successful builds are:
  --> azure-arm: Azure.ResourceManagement.VMImage:

  OSType: Linux
  ManagedImageResourceGroupName: packer-images-rg
  ManagedImageName: UbuntuServerPackerImage
  ManagedImageId: /subscriptions/02dbcxxxx-xxxxxxxxx-xxxxxx-xxxxx/resourceGroups/packer-images-rg/providers/Microsoft.Compute/images/UbuntuServerPackerImage
  ManagedImageLocation: West US 2
  ```

2. Terraform: [Terraform apply output should be similar to this](https://github.com/mudathirlawal/azure-terraform-packer-iac/blob/ops/terraform-apply-output.txt) 
 
## Clean up provisioned infrasture as a service (IaaS) 

To avoid incurring ongoing charges for any Azure resources you created in this walkthrough, run `terrafform destroy` in the project directory, then delete the resource group that contains the deployed infrastructure. To delete the resource group from the Azure portal, select __Resource groups__ in the left navigation. In the resource group list, select the `...` to the right of 
the resource group you want to delete, select __Delete resource group__, and follow the prompts.
You can also use `az group delete` in the Cloud Shell to delete resource groups.

To delete the storage account that maintains the file system for Cloud Shell, which incurs a small monthly charge, delete the resource group that begins with __cloud-shell-storage-__.

## Further improvements

This project can be adapted for use in a microservice architecture where the application is deployed into Azure from a Kubernetes cluster.     

## References

- Microsoft 2021, accessed 2021-01-23,\
  <https://microsoft.github.io/AzureTipsAndTricks/blog/tip201.html>
- Microsoft 2021, accessed 2021-01-23,\
  <https://docs.microsoft.com/en-us/azure/virtual-machines/linux/build-image-with-packer>