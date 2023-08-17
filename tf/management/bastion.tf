data "hcloud_ssh_keys" "all_keys" {
}

data "hcloud_image" "debian" {
  name              = "debian-12"
  with_architecture = "arm"
}

data "hcloud_server_type" "cax11" {
  name = "cax11"
}

resource "hcloud_server" "bastion-mgmt" {
  name        = "bastion-mgtm"
  image       = data.hcloud_image.debian.id
  server_type = data.hcloud_server_type.cax11.name
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  ssh_keys = data.hcloud_ssh_keys.all_keys.ssh_keys.*.name

  depends_on = [
    hcloud_network_subnet.mgmt-net-subnet,
  ]
}

resource "hcloud_server_network" "bastion-mgmt-net" {
  server_id = hcloud_server.bastion-mgmt.id
  subnet_id = hcloud_network_subnet.mgmt-net-subnet.id
  ip        = "10.10.0.2"
}


resource "hcloud_firewall_attachment" "bastion-mgmt-firewall-attachment" {
  firewall_id = hcloud_firewall.mgmt-firewall.id
  server_ids  = [hcloud_server.bastion-mgmt.id]
}
