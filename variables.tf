variable "domain_name" {
  description = "Define Domain name"
  type        = string
  default     = "webapp.kubecloud.net"
}
variable "validation_method" {
  description = "Define Validation Method"
  type        = string
  default     = "DNS"  ## DNS or EMAIL
}