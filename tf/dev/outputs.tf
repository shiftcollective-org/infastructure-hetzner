output "bastion_ip" {
  description = "Public IP of the bastion"
  value       = hcloud_server.bastion-dev.ipv4_address
}
