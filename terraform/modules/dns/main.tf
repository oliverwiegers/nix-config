resource "desec_domain" "domains" {
  for_each = var.domains

  name = each.key
}

resource "desec_rrset" "records" {
  for_each = merge(values({
    for domain, properties in var.domains : domain => {
      for record, record_properties in properties.records : "${record_properties.type}-${record_properties.subname}-${domain}" => merge(record_properties, { domain = domain })
    }
  })...)

  domain  = each.value.domain
  subname = each.value.subname
  type    = each.value.type
  records = each.value.records
  ttl     = each.value.ttl
}
