locals {
  address_ranges = {
    "dev"  = "10.20.0.0/16"
    "mgmt" = "10.10.0.0/16"
  }
  firewall_ip = {
    "dev"  = "10.20.0.254"
    "mgmt" = "10.10.0.254"
  }
  bastion_ip = "10.20.0.2"
}
