# Management network
resource "hcloud_network" "mgtm-net" {
  name     = "mgtm-net"
  ip_range = local.address_ranges["mgmt"]
}

# Demonstration of usage of a resource outside
# this module. The bastion from the dev network
# is imported as a data source to get its IP.
data "hcloud_server" "dev-bastion" {
  name = "dev-bastion"
}

resource "hcloud_firewall" "mgmt-firewall" {
  name = "dev-bastion-to-mgmt"
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      # TODO this is the public IP, we want the private IP.
      data.hcloud_server.dev-bastion.ipv4_address
    ]
  }
}
