resource "azurerm_resource_group" "RG1" {
  name     = "Genex-resources"
  location = "East US"

}

resource "azurerm_kubernetes_cluster" "k8cluster" {
  name                = "Genex-k8s"
  location            = azurerm_resource_group.RG1.location
  resource_group_name = azurerm_resource_group.RG1.name
  dns_prefix          = "genexcorp"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2_v3"
  }
  identity {
    type = "SystemAssigned"
  }
  tags = {
    Environment = "Dev"
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.k8cluster.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.k8cluster.kube_config_raw
  sensitive = true
}
