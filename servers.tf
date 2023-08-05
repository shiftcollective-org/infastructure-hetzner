data "hcloud_ssh_keys" "all_keys" {
}

# Create a new server running debian
resource "hcloud_server" "bastion-dev" {
  name        = "bastion-dev"
  image       = "debian-12"
  server_type = "cax11"
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  ssh_keys = data.hcloud_ssh_keys.all_keys.ssh_keys.*.name

  depends_on = [
    hcloud_network_subnet.development,
    hcloud_network_subnet.management
  ]
}

resource "hcloud_server_network" "bastion-dev-net" {
  server_id = hcloud_server.bastion-dev.id
  subnet_id = hcloud_network_subnet.development.id
  ip        = "10.20.0.2"
  alias_ips = ["10.10.0.2"]
}

