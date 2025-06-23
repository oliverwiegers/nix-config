variable "domains" {
  type = map(object({
    records = optional(list(object({
      type    = string
      records = list(string)
      subname = optional(string, "")
      ttl     = optional(number, 3600)
    })), [])
  }))
}
