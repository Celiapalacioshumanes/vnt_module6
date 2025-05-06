variable "owner_tag" {
  description = "Propietario de la VNet"
  type        = string

  validation {
    condition     = length(trim(var.owner_tag, " ")) > 0
    error_message = "El valor de 'owner_tag' no puede estar vacío."
  }
}

variable "vnet_address_space" {
  description = "Espacio de direcciones de la VNet"
  type        = list(string)
}

variable "environment_tag" {
  description = "Entorno de la VNet (dev, test, prod, etc.)"
  type        = string

  validation {
    condition = contains(["DEV", "PRO", "TES", "PRE"], upper(trim(var.environment_tag, " ")))
    error_message = "El valor de 'environment_tag' debe ser uno de: DEV, PRO, TES, PRE (mayúsculas o minúsculas)."
  }
}

variable "existent_resource_group_name" {
  description = "Nombre del grupo de recursos existente"
  type        = string
}

variable "location" {
  description = "Ubicación del recurso"
  type        = string
}

variable "vnet_name" {
  description = "Nombre de la VNet"
  type        = string

  validation {
    condition     = length(trim(var.vnet_name, " ")) > 0
    error_message = "El valor de 'vnet_name' no puede estar vacío."
  }

  # Validación con expresión regular para la opción difícil
  validation {
    condition = can(regex("^vnet[a-z]{3,}tfexercise[0-9]{2,}$", lower(var.vnet_name)))
    error_message =  "El valor de 'vnet_name' no cumple con el formato requerido. Debe comenzar por 'vnet', seguido de al menos 3 letras minúsculas, luego 'tfexercise', y terminar con al menos dos dígitos. Ejemplo válido: vnetprodrigueztfexercise01"
}
}

variable "vnet_tags" {
  description = "Tags adicionales que se aplicarán a la VNet"
  type        = map(string)
  default     = {}

  validation {
    condition = alltrue([
      for val in values(var.vnet_tags) :
      val != null && length(trim(val, "")) > 0
    ])
    error_message = "Ningún valor en 'vnet_tags' puede ser null ni una cadena vacía."
  }
}
