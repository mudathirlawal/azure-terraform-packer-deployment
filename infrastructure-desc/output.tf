output "LoadbalancerIpId" {
    description = "Refers to the public IP address of the internet-facing LB."
    value = azurerm_public_ip.main.id     
}