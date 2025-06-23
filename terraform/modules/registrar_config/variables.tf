variable "domains" {
  description = "Domains to configure."
  default     = {}

  type = map(object({
    nameservers = optional(list(string), ["ns1.desec.io", "ns2.desec.org"])
    extra_data  = optional(map(string), {})
  }))
}

variable "domain_admin" {
  description = "Admin contact for domain registrar."
  default     = null

  type = object({
    type         = optional(string, "PERSON")
    name         = string
    address      = string
    city         = string
    postal_code  = number
    country_code = string
    phone_number = string
    email        = string
  })

}
