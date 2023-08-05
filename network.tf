# Main network    10.0.0.0/8
# mgmt-network    10.10.0.0/16
# dev-network     10.20.0.0/16
# stage-network   10.30.0.0/16
# prod-network    10.40.0.0/16

resource "hcloud_network" "shiftCollective" {
  name     = "shiftcollective-net"
  ip_range = "10.0.0.0/8"
}

resource "hcloud_network_subnet" "management" {
  network_id   = hcloud_network.shiftCollective.id
  type         = "cloud"
  ip_range     = "10.10.0.0/16"
  network_zone = "eu-central"
}

resource "hcloud_network_subnet" "development" {
  network_id   = hcloud_network.shiftCollective.id
  type         = "cloud"
  ip_range     = "10.20.0.0/16"
  network_zone = "eu-central"
}

