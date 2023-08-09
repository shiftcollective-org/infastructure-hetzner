# Network for the dev environment
resource "hcloud_network" "dev-net" {
  name     = "dev-net"
  ip_range = local.address_ranges["dev"]
}

resource "hcloud_network_subnet" "dev-net-subnet" {
  type         = "cloud"
  network_zone = "eu-central"
  network_id   = hcloud_network.dev-net.id
  ip_range     = local.address_ranges["dev"]
}

resource "hcloud_network_route" "mgmt-net-route" {
  network_id  = hcloud_network.dev-net.id
  destination = "10.10.0.0/16"
  gateway     = "10.20.0.254"
}

