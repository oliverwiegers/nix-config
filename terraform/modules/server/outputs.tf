output "name" {
  description = "Name of server."
  value       = hcloud_server.server.name
}

output "hostname" {
  description = "Hostname of server."
  value = var.hostname
}

output "primary_ipv4" {
  description = "Primary IPv4 IP."
  value       = hcloud_primary_ip.ipv4.ip_address
}

output "host_id" {
  description = "Host ID used for mounting ZFS pools."
  value       = random_id.host_id.hex
}
