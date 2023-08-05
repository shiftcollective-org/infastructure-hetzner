# Network for the dev environment
resource "hcloud_network" "dev-net" {
  name     = "dev-net"
  ip_range = local.address_ranges["dev"]
}
