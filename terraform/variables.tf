variable "ssh_keys" {
  description = "SSH keys to assign to project and servers."
  default     = {}

  type = map(object({
    key    = string
    labels = optional(map(string), null)
  }))
}

variable "servers" {
  description = "Map of servers."
  default     = {}

  type = map(object({
    image      = optional(string, "ubuntu-24.04")
    type       = optional(string, "cx22")
    datacenter = optional(string, "fsn1-dc14")
    ptr        = optional(string, null)
    ssh_keys   = optional(list(string), null)
    domain     = optional(string, null)
    bootstrap_nixos = optional(bool, true)
  }))
}

variable "s3_buckets" {
  description = "Hetzner S3 buckets to set up."

  default = {
    prefix  = null
    buckets = []
  }

  type = object({
    prefix  = string
    buckets = list(string)

  })
}

variable "domains" {
  type = map(object({
    type        = optional(string, "dns")
    nameservers = optional(list(string), ["ns1.desec.io", "ns2.desec.org"])
    extra_data  = optional(map(string), {})

    records = optional(list(object({
      type    = string
      records = list(string)
      subname = optional(string, "")
      ttl     = optional(number, 3600)
    })), [])
  }))

  validation {
    condition = alltrue([
      for domain in values(var.domains) : contains(["dns", "internal", "home", "external"], domain.type)
    ])
    error_message = "Allowed values for domains.<name>.type  are [\"dns\", \"internal\", \"home\", \"external\"]."
  }
}

variable "dns" {
  type = object({
    provider = string
    resolver = string
  })
}
