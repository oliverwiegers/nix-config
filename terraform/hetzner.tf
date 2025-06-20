locals {
  live_hosts = {
    for server in module.servers : server.name => {
      ipv4    = server.primary_ipv4
      host_id = server.host_id
    }
  }

  servers    = {
    for server, properties in var.servers : server => {
      image      = properties.image
      type       = properties.type
      datacenter = properties.datacenter
      ptr        = properties.ptr
      ssh_keys   = properties.ssh_keys
      domain     = properties.domain != null ? properties.domain : local.domain
    }
  }
}

resource "hcloud_ssh_key" "keys" {
  for_each = var.ssh_keys

  name       = each.key
  public_key = each.value.key
  labels     = each.value.labels
}

resource "minio_s3_bucket" "buckets" {
  for_each = { for bucket in var.s3_buckets.buckets : bucket => {} }

  bucket = var.s3_buckets.prefix != null ? "${var.s3_buckets.prefix}-${each.key}" : each.key
}

module "servers" {
  source = "${path.root}/modules/server"

  for_each = local.servers

  hostname   = each.key
  domain     = each.value.domain
  image      = each.value.image
  type       = each.value.type
  datacenter = each.value.datacenter
  ptr        = each.value.ptr
  ssh_keys   = [for key in hcloud_ssh_key.keys : key.id]

  depends_on = [ module.registrar_config ]
}
