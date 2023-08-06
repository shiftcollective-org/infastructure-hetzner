# Network for the dev environment
data "hcloud_network" "shift-net" {
  name = "shift-net"
}
# resource "hcloud_network" "dev-net" {
# name     = "dev-net"
# ip_range = local.address_ranges["dev"]
# }

resource "hcloud_network_subnet" "dev-net-subnet" {
  type         = "cloud"
  network_zone = "eu-central"
  network_id   = data.hcloud_network.shift-net.id
  ip_range     = local.address_ranges["dev"]
}

# Allow public traffic to SSH port
resource "hcloud_firewall" "dev-bastion-firewall" {
  name = "ssh-to-dev-bastion"
  rule {
    destination_ips = [
      format("%s/%s", hcloud_server.bastion-dev.ipv4_address, "32")
    ]
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0"
    ]
  }
}
