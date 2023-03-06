variable "domain_name" {
  description = "Define Domain name"
  type        = string
  default     = "webapp.kubecloud.net"
}

variable "validation_method" {
  description = "Define Validation Method"
  type        = string
  default     = "DNS" ## DNS or EMAIL
}

variable "hosted_zone_name" {
  description = "Define Hosted Zone Name"
  type        = string
  default     = "kubecloud.net"
}

variable "determine_zone_type" {
  description = "Determine Zone Type"
  type        = bool
  default     = false  
  # false = public zone
  # true = private zone
}

variable "allow_create_before_destroy_policy" {
  description = "Define Create Before Destroy Lifecycle Policy"
  type        = bool
  default     = true
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
  description = "Determine Record Overwite"
  type        = number
  default     = 60
}
