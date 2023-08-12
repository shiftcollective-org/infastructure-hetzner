# Once a rule is defined, there is an implicit default deny
resource "hcloud_firewall" "bastion-mgmt-firewall" {
  name = "bastion_to_ssh_from_all"
  rule {
    destination_ips = [
      format("%s/%s", hcloud_server.bastion-mgmt.ipv4_address, "32")
    ]
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0"
    ]
  }
}

resource "hcloud_firewall_attachment" "bastion-dev-ssh-firewall-attachment" {
  firewall_id = hcloud_firewall.bastion-mgmt-firewall.id
  server_ids  = [hcloud_server.bastion-mgmt.id]
}
