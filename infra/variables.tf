
variable "project" { type = string }
variable "env"     { type = string }

variable "location" {
  type    = string
  default = "southindia"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.10.0.0/16"]
}

variable "subnets" {
  description = "Map of subnet names to CIDRs"
  type = map(string)
  default = {
    "snet-app"  = "10.10.1.0/24"
    "snet-data" = "10.10.2.0/24"
  }
}

variable "tags" {
  type = map(string)
  default = {
    "owner"       = "levi"
    "managedBy"   = "terraform"
    "environment" = "dev"
  }
}
