# Network for the dev environment
resource "hcloud_network" "dev-net" {
  name     = "dev-net"
  ip_range = local.address_ranges["dev"]
}

# Allow public traffic to SSH port
resource "hcloud_firewall" "dev-bastion-firewall" {
  name = "ssh-to-dev-bastion"
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0"
    ]
  }
}
