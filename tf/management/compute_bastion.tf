resource "hcloud_server" "bastion-mgmt" {
  name        = "bastion-mgmt"
  image       = data.hcloud_image.debian-12-arm.id
  server_type = data.hcloud_server_type.cax11.name
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
  ssh_keys = data.hcloud_ssh_keys.all_keys.ssh_keys.*.name

  depends_on = [
    hcloud_network_subnet.mgmt-net-subnet,
  ]
}

resource "hcloud_server_network" "bastion-mgmt-net" {
  server_id = hcloud_server.bastion-mgmt.id
  subnet_id = hcloud_network_subnet.mgmt-net-subnet.id
  ip        = local.bastion_ip
}
