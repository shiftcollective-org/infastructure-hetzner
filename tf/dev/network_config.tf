# Network for the dev environment
resource "hcloud_network" "dev-net" {
  name     = "dev-net"
  ip_range = local.address_ranges["dev"]
}

# We need a subnet to add servers
resource "hcloud_network_subnet" "dev-net-subnet" {
  type         = "cloud"
  network_zone = "eu-central"
  network_id   = hcloud_network.dev-net.id
  ip_range     = local.address_ranges["dev"]
}

# Route to management network
# Hetzner needs to know that to send traffic
# to mgtm range, the gateway is our firewall IP
resource "hcloud_network_route" "mgmt-net-route" {
  network_id  = hcloud_network.dev-net.id
  destination = local.address_ranges["mgmt"]
  gateway     = local.firewall_ip["dev"]
}

