variable "prefix" {
    description = "This is the project name; it is prefixed to most resources."
    default = "udacity"
}

variable "location" {
    description = "Azure Region wherein this resource is deployed."
    default = "West US 2"
}

variable "vmCount" {
    description = "This is the total number of deployed VMs."
    default = 2
}

variable "adminUsername" {
    description = "Admin username for this VM."
    default = "RemoteUser"
}

variable "adminPassword" {
    description = "Admin password for this VM."
    default = "DevOpsIsSweet@2021"
}

variable "diskSizeGB" {
    description = "Specifies the disk size of the managed disk."
    default = 1
}