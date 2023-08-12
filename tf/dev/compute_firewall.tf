resource "hcloud_server" "firewall-dev" {
  name        = "firewall-dev"
  image       = data.hcloud_image.debian-12-arm.id
  server_type = data.hcloud_server_type.cax11.name
  # Firewall does not need public IP
  public_net {
    ipv4_enabled = false
    ipv6_enabled = false
  }
  ssh_keys = data.hcloud_ssh_keys.all_keys.ssh_keys.*.name

  depends_on = [
    hcloud_network_subnet.dev-net-subnet,
  ]
}

# Assing the firewall to the "dev" network
resource "hcloud_server_network" "firewall-dev-net" {
  server_id = hcloud_server.firewall-dev.id
  subnet_id = hcloud_network_subnet.dev-net-subnet.id
  ip        = local.firewall_ip["dev"]
}

# Assing the firewall to the "mgmt" network
resource "hcloud_server_network" "firewall-mgmt-net" {
  server_id  = hcloud_server.firewall-dev.id
  network_id = data.hcloud_network.mgmt-net.id
  ip         = local.firewall_ip["mgmt"]
}


