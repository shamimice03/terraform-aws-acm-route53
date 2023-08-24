variable "domain_name" {
  description = "Define Domain name"
  type        = string
  default     = ""
}

variable "validation_method" {
  description = "Define Validation Method. `DNS` or `EMAIL`"
  type        = string
  default     = "DNS" ## DNS or EMAIL
}

variable "hosted_zone_name" {
  description = "Define Hosted Zone Name"
  type        = string
  default     = ""
}

variable "private_zone" {
  description = "Determine Zone Type. `false` leads to `public zone` and `true` for `private zone`"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Define Tags"
  type        = map(any)
  default = {
    "Name" = "ssl-cert"
  }
}

variable "allow_record_overwrite" {
  description = "Determine Record Overwite"
  type        = bool
  default     = true
}

variable "ttl" {
  description = "Define ttl"
  type        = number
  default     = 60
}
