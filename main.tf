terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.27.0"
    }
  }
}

# Configuración del proveedor de Azure
provider "azurerm" {
  features {}
}

# Combinar tags obligatorios con opcionales (sobrescribibles)
locals {
  base_tags = {
    owner       = var.owner_tag
    environment = var.environment_tag
  }

  final_tags = merge(local.base_tags, var.vnet_tags)
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.existent_resource_group_name

  tags = local.final_tags
}
