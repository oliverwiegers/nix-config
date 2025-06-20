variable "host" {
  description = "IP or FQDN of host to bootstrap."
  type = string
  nullable = false
}

variable "hostname" {
  description = "Hostname. Will be used to determine the flake output containing the NixOS config."
  type = string
  nullable = false
}

variable "instance_id" {
  description = "Instance ID of host. If changed the hosts will be redeployed."
  type = string
  nullable = false
}
