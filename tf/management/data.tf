# This will load all the keys that are loaded in Hetzner
# console and will add them to the machine for the root
# user. This is needed until the Vault solution is in 
# place with our own customized image.
# https://github.com/shiftcollective-org/Shift-Collective-Projects/issues/13
# https://github.com/shiftcollective-org/Shift-Collective-Projects/issues/10
data "hcloud_ssh_keys" "all_keys" {
}


data "hcloud_image" "debian-12-arm" {
  name              = "debian-12"
  with_architecture = "arm"
}

# ARM64
# 2vCPU 4GB 40GB 20TB €3.29/mo
data "hcloud_server_type" "cax11" {
  name = "cax11"
}

