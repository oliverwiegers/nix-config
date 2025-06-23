locals {
  name = var.domain != null ? "${var.hostname}.${var.domain}" : var.hostname
}

resource "hcloud_primary_ip" "ipv4" {
  name          = "${local.name}-ipv4"
  datacenter    = var.datacenter
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = false
}

resource "hcloud_rdns" "rnds" {
  count = var.ptr != null ? 1 : 0

  primary_ip_id = hcloud_primary_ip.ipv4.id
  ip_address    = hcloud_primary_ip.ipv4.ip_address
  dns_ptr       = var.ptr
}

resource "hcloud_server" "server" {
  name        = local.name
  image       = var.image
  server_type = var.type
  datacenter  = var.datacenter
  ssh_keys    = var.ssh_keys

  public_net {
    ipv4_enabled = true
    ipv4         = hcloud_primary_ip.ipv4.id
    ipv6_enabled = false
  }
}

resource "random_id" "host_id" {
  byte_length = 4
}

resource "null_resource" "wait_for_server" {
  provisioner "local-exec" {
    command = "bash ${path.root}/../scripts/wait_for_ssh.sh ${hcloud_primary_ip.ipv4.ip_address}"
  }

  triggers = {
    ip_address = hcloud_primary_ip.ipv4.ip_address
    host_id    = random_id.host_id.hex
  }
}
