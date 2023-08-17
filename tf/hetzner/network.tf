# Network for the dev environment
resource "hcloud_network" "shift-net" {
  name     = "shift-net"
  ip_range = local.address_ranges["shift-infra"]
}

