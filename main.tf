module "vnet" {
  source = "git::https://github.com/Celiapalacioshumanes/vnt_module6.git"

  vnet_name                    = "vnetceliatfexercise07"
  vnet_address_space           = ["10.2.0.0/16"]
  location                     = "westeurope"
  existent_resource_group_name = "rg-cpalacios-dvfinlab"
  owner_tag       = "Celia"
  environment_tag = "dev"
  vnet_tags = {
    proyecto = "TF-Ejercicio07"
  }

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
