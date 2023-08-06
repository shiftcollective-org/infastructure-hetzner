data "hcloud_network" "shift-net" {
  name = "shift-net"
}
# Management network
# resource "hcloud_network" "mgmt-net" {
# name     = "mgmt-net"
# ip_range = local.address_ranges["mgmt"]
# }

resource "hcloud_network_subnet" "mgmt-net-subnet" {
  type         = "cloud"
  network_zone = "eu-central"
  network_id   = data.hcloud_network.shift-net.id
  ip_range     = local.address_ranges["mgmt"]
}

# Demonstration of usage of a resource outside
# this module. The bastion from the dev network
# is imported as a data source to get its IP.
data "hcloud_server" "dev-bastion" {
  name = "bastion-dev"
}

resource "hcloud_firewall" "mgmt-firewall" {
  name = "dev-bastion-to-mgmt"
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0"
    ]
  }
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "9200"
    source_ips = [
      "10.0.0.0/8"
    ]
  }
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "5001"
    source_ips = [
      "10.10.0.0/16"
    ]
  }
}
