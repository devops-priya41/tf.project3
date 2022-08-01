data "azurerm_client_config" "current" {   
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "Priya_RG" {
  name     = var.pk_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_key_vault" "keyvault" {
  name                       = "priyakeyvault"
  location                   = azurerm_resource_group.Priya_RG.location
  resource_group_name        = azurerm_resource_group.Priya_RG.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]
  }
}

resource "azurerm_kubernetes_cluster" "kubcluster" {
  name                = "aks-cluster1"
  location            = azurerm_resource_group.Priya_RG.location
  resource_group_name = azurerm_resource_group.Priya_RG.name
  dns_prefix          = "aks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = azurerm_resource_group.Priya_RG.tags
}

resource "random_password" "random_password" {
  length  = 20
  special = true
}

resource "azurerm_key_vault_secret" "secretkey" {
  for_each                    = var.secret_names
  name                        = each.key
  value                       = each.value
  key_vault_id = azurerm_key_vault.keyvault.id
  
  depends_on = [
    azurerm_kubernetes_cluster.kubcluster,
    azurerm_key_vault.keyvault,
  ]

}