variable "prefix" {
    description = "The text that is prefixed to this resource."
}

variable "location" {
    description = "Azure Region wherein this resource is deployed."
    default = "West US 2"
}

variable "vmSize" {
    description = "This specifies the desired type of VM."
    default = "Standard_B1s"
}

variable "vmCount" {
    description = "This is the total number of deployed VMs."
    default = 1
}

variable "resourceGrp" {
    description = "Represents the resource group accommodating the service."
}

variable "storageAccType" {
    description = "Specifies the type of disk storage account used."
    default = "Standard_LRS"
}

variable "adminUserName" {
    description = "Admin username for this VM."
}

variable "adminPassword" {
    description = "Admin password for this VM."
}

variable "diskSizeGB" {
    description = "Specifies the disk size of the managed disk."
    default = 1
}