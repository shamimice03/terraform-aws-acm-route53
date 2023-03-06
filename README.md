## Request SSL/TLS Certficate

## Usage
```
module "vpc" {

source = "github.com/shamimice03/terraform-aws-vpc"

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
```


