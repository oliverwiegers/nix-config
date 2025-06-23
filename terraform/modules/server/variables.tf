variable "domain" {
  description = "Domain of server."
  type        = string
  default     = null
}

variable "hostname" {
  description = "Hostname of server."
  type        = string
}

variable "image" {
  description = "Name of ISO image for server."
  default     = "ubuntu-24.04"
  type        = string
}

variable "type" {
  description = "Server type."
  default     = "cx-22"
  type        = string
}

variable "datacenter" {
  description = "Datacenter to spawn server in."
  default     = "fsn1-dc14"
  type        = string
}

variable "ptr" {
  description = "DNS reverse record."
  default     = null
  type        = string
}

variable "ssh_keys" {
  description = "SSH keys for server access."
  type        = list(string)
  default     = null
}
