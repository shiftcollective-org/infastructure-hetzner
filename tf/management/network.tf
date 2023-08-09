# Management network
resource "hcloud_network" "mgmt-net" {
  name     = "mgmt-net"
  ip_range = local.address_ranges["mgmt"]
}

resource "hcloud_network_subnet" "mgmt-net-subnet" {
  type         = "cloud"
  network_zone = "eu-central"
  network_id   = hcloud_network.mgmt-net.id
  ip_range     = local.address_ranges["mgmt"]
}

