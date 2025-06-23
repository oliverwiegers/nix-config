domains = {
  "oliverwiegers.com" = {
    type = "external"

    extra_data = {
      "WHOIS-PROTECTION" = "1"
    }

    records = [
      {
        type    = "CNAME"
        subname = "www"
        records = ["oliverwiegers.com."]
      },

      {
        type    = "CNAME"
        subname = "mx"
        records = ["dudek.oliverwiegers.com."]
      },

      {
        type    = "CNAME"
        subname = "vpn"
        records = ["dudek.oliverwiegers.com."]
      },

      {
        type    = "A"
        subname = "kryha"
        records = ["152.53.49.50"]
      },

      {
        type    = "CNAME"
        subname = "auth"
        records = ["kryha.oliverwiegers.com."]
      },

      {
        type    = "CNAME"
        subname = "cal"
        records = ["mx.oliverwiegers.com."]
      },

      {
        type    = "MX"
        records = ["0 mx.oliverwiegers.com."]
      },

      {
        type    = "TXT"
        subname = "mx._domainkey"
        records = ["v=DKIM1; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDTUxQYF3jU/2kJtTi/je8gEqoX1YLBojMiEGlJB8h67xRbHX/ORib9rQH/pEaxso+rXJoY92IkpHUatsZ2+394xTZ60Rrl3jidl9P936cOQQJn7c6HPaMlkdYNIr/cvlLBVW6YKt6sblZ33+QmwQinV8meAHZbEJRQzMi1J7KE+QIDAQAB"]
      },

      {
        type    = "TXT"
        subname = "_dmarc"
        records = ["v=DMARC1; p=none"]
      },
    ]
  }

  "oliverwiegers.de" = {
    type = "internal"
  }
}

ssh_keys = {
  "MacBook" = {
    key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINKvcXlse6olKBEiRpfPclT4Pn31lpQ4fbZHNv5MBXat"
  }
}

servers = {
  "dudek" = {
    ptr = "mx.oliverwiegers.com"
  }

  "rockex" = {}

  # Netcup replacement.
  # "kryha" = {
  #   type = "cx32"
  # }
}

s3_buckets = {
  prefix  = "oliverwiegers"
  buckets = ["terraform-state", "backups"]
}

dns = {
  provider = "desec",
  resolver = "ns1.desec.io:53"
}
