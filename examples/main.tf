module "acm" {

source = "github.com/shamimice03/terraform-aws-acm-route53"

domain_name = "webapp.kubecloud.net"
validation_method = "DNS"
hosted_zone_name = "kubecloud.net"
private_zone = false
allow_record_overwrite = true
ttl = 60
tags = {
    "Name" = "ssl-cert"
}

}