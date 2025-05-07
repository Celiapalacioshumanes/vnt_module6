#module "vnet" {
  #source = "git::https://github.com/Celiapalacioshumanes/vnt_module6.git"

  #vnet_name                    = "vnetceliatfexercise07"
  #vnet_address_space           = ["10.2.0.0/16"]
  #location                     = "westeurope"
  #existent_resource_group_name = "rg-cpalacios-dvfinlab"
  #owner_tag       = "Celia"
  #environment_tag = "dev"
  #vnet_tags = {
  #  proyecto = "TF-Ejercicio07"
 # }

  subnets = [
    {
      name             = "subnet1"
      address_prefixes = ["10.2.1.0/24"]
    },
    {
      name             = "subnet2"
      address_prefixes = ["10.2.2.0/24"]
      nsg = {
        name = "nsg-subnet2"
        security_rules = [
          {
            name                       = "AllowHTTP"
            priority                   = 100
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            destination_port_range     = "80"
            source_address_prefix      = "*"
            destination_address_prefix = "*"
          }
        ]
      }
    }
  ]
}
