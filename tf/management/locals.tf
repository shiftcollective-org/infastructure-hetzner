locals {
  address_ranges = {
    "dev"  = "10.20.0.0/16"
    "mgmt" = "10.10.0.0/16"
  }
  bastion_ip = "10.10.0.2"
}
