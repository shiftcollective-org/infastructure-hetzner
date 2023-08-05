# This will load all the keys that are loaded in Hetzner
# console and will add them to the machine for the root
# user. This is needed until the Vault solution is in 
# place with our own customized image.
# https://github.com/shiftcollective-org/Shift-Collective-Projects/issues/13
# https://github.com/shiftcollective-org/Shift-Collective-Projects/issues/10
data "hcloud_ssh_keys" "all_keys" {
}

data "hcloud_image" "debian" {
  name = "debian-12"
}

# ARM64
# 2vCPU 4GB 40GB 20TB €3.29/mo
data "hcloud_server_type" "cax11" {
  name = "cax11"
}

# Create a new server running debian
resource "hcloud_server" "bastion-dev" {
  name        = "bastion-dev"
  image       = data.hcloud_image.debian.id
  server_type = data.hcloud_server_type.cax11.id
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  ssh_keys = data.hcloud_ssh_keys.all_keys.ssh_keys.*.name

  depends_on = [
    hcloud_network.dev-net,
  ]
}

resource "hcloud_server_network" "bastion-dev-net" {
  server_id  = hcloud_server.bastion-dev.id
  network_id = hcloud_network.dev-net.id
  ip         = "10.20.0.2"
}


resource "hcloud_firewall_attachment" "bastion-dev-firewall-attachment" {
  firewall_id = hcloud_firewall.dev-bastion-firewall.id
  server_ids  = [hcloud_server.bastion-dev.id]
}
