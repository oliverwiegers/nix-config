resource "inwx_domain" "domains" {
  for_each = var.domains

  name        = each.key
  nameservers = each.value.nameservers
  period      = "1Y"
  extra_data  = each.value.extra_data

  contacts {
    registrant = inwx_domain_contact.admin.id
    admin      = inwx_domain_contact.admin.id
    tech       = 1
    billing    = 1
  }
}

resource "inwx_domain_contact" "admin" {
  type           = "PERSON"
  name           = var.domain_admin.name
  street_address = var.domain_admin.address
  city           = var.domain_admin.city
  postal_code    = var.domain_admin.postal_code
  country_code   = var.domain_admin.country_code
  phone_number   = var.domain_admin.phone_number
  email          = var.domain_admin.email
}
