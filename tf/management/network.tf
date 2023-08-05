# Management network
resource "hcloud_network" "mgtm-net" {
  name     = "mgtm-net"
  ip_range = local.address_ranges["mgmt"]
}
