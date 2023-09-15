```
  for_each = {
    for cert in aws_acm_certificate.cert : cert.domain_name => {
      name   = tolist(cert.domain_validation_options)[0].resource_record_name
      record = tolist(cert.domain_validation_options)[0].resource_record_value
      type   = tolist(cert.domain_validation_options)[0].resource_record_type
    }
  }
```
```
{
  "awsref.kubecloud.net" = {
    name   = "_924d0bd8c256df8bc1dfd5023133050e.awsref.kubecloud.net."
    record = "_236c3bff582111f89ad5f04a2df2c7a7.rprhmdzstb.acm-validations.aws."
    type   = "CNAME"
  },
  "www.awsref.kubecloud.net" = {
    name   = "_1aea94242136fa013a7d35752ffc146c.www.awsref.kubecloud.net."
    record = "_7418a7bdd7e339fcd681137257e4f771.rprhmdzstb.acm-validations.aws."
    type   = "CNAME"
  }
}
```

From:

```
> aws_route53_record.validation
{
  "awsref.kubecloud.net" = {
    "alias" = tolist([])
    "allow_overwrite" = true
    "cidr_routing_policy" = tolist([])
    "failover_routing_policy" = tolist([])
    "fqdn" = "_924d0bd8c256df8bc1dfd5023133050e.awsref.kubecloud.net"
    "geolocation_routing_policy" = tolist([])
    "health_check_id" = ""
    "id" = "Z0026882202J6NT8GTRRL__924d0bd8c256df8bc1dfd5023133050e.awsref.kubecloud.net._CNAME"
    "latency_routing_policy" = tolist([])
    "multivalue_answer_routing_policy" = false
    "name" = "_924d0bd8c256df8bc1dfd5023133050e.awsref.kubecloud.net"
    "records" = toset([
      "_236c3bff582111f89ad5f04a2df2c7a7.rprhmdzstb.acm-validations.aws.",
    ])
    "set_identifier" = ""
    "ttl" = 60
    "type" = "CNAME"
    "weighted_routing_policy" = tolist([])
    "zone_id" = "Z0026882202J6NT8GTRRL"
  }
  "www.awsref.kubecloud.net" = {
    "alias" = tolist([])
    "allow_overwrite" = true
    "cidr_routing_policy" = tolist([])
    "failover_routing_policy" = tolist([])
    "fqdn" = "_1aea94242136fa013a7d35752ffc146c.www.awsref.kubecloud.net"
    "geolocation_routing_policy" = tolist([])
    "health_check_id" = ""
    "id" = "Z0026882202J6NT8GTRRL__1aea94242136fa013a7d35752ffc146c.www.awsref.kubecloud.net._CNAME"
    "latency_routing_policy" = tolist([])
    "multivalue_answer_routing_policy" = false
    "name" = "_1aea94242136fa013a7d35752ffc146c.www.awsref.kubecloud.net"
    "records" = toset([
      "_7418a7bdd7e339fcd681137257e4f771.rprhmdzstb.acm-validations.aws.",
    ])
    "set_identifier" = ""
    "ttl" = 60
    "type" = "CNAME"
    "weighted_routing_policy" = tolist([])
    "zone_id" = "Z0026882202J6NT8GTRRL"
  }
}
```

To:
```
{
    "awsref.kubecloud.net": "_924d0bd8c256df8bc1dfd5023133050e.awsref.kubecloud.net",
    "www.awsref.kubecloud.net": "_1aea94242136fa013a7d35752ffc146c.www.awsref.kubecloud.net",
}
```

process:
```
locals {
  fqdns = {
    for key, record in aws_route53_record.validation : key => record.fqdn
  }
}
```
***
From this:
```
> aws_acm_certificate.cert
[
  {
    "arn" = "arn:aws:acm:ap-northeast-1:391178969547:certificate/2933fa9b-0c9f-47e0-961c-cf2dfe090016"
    "certificate_authority_arn" = ""
    "certificate_body" = tostring(null)
    "certificate_chain" = tostring(null)
    "domain_name" = "awsref.kubecloud.net"
    "domain_validation_options" = toset([
      {
        "domain_name" = "awsref.kubecloud.net"
        "resource_record_name" = "_924d0bd8c256df8bc1dfd5023133050e.awsref.kubecloud.net."
        "resource_record_type" = "CNAME"
        "resource_record_value" = "_236c3bff582111f89ad5f04a2df2c7a7.rprhmdzstb.acm-validations.aws."
      },
    ])
    "early_renewal_duration" = ""
    "id" = "arn:aws:acm:ap-northeast-1:391178969547:certificate/2933fa9b-0c9f-47e0-961c-cf2dfe090016"
    "key_algorithm" = "RSA_2048"
    "not_after" = "2024-10-14T23:59:59Z"
    "not_before" = "2023-09-15T00:00:00Z"
    "options" = tolist([
      {
        "certificate_transparency_logging_preference" = "ENABLED"
      },
    ])
    "pending_renewal" = false
    "private_key" = (sensitive value)
    "renewal_eligibility" = "INELIGIBLE"
    "renewal_summary" = tolist([])
    "status" = "ISSUED"
    "subject_alternative_names" = toset([
      "awsref.kubecloud.net",
    ])
    "tags" = tomap({
      "Name" = "ssl-cert"
    })
    "tags_all" = tomap({
      "Name" = "ssl-cert"
    })
    "type" = "AMAZON_ISSUED"
    "validation_emails" = tolist([])
    "validation_method" = "DNS"
    "validation_option" = toset([])
  },
  {
    "arn" = "arn:aws:acm:ap-northeast-1:391178969547:certificate/55cda95d-693a-43da-a011-ea0b45f82e43"
    "certificate_authority_arn" = ""
    "certificate_body" = tostring(null)
    "certificate_chain" = tostring(null)
    "domain_name" = "www.awsref.kubecloud.net"
    "domain_validation_options" = toset([
      {
        "domain_name" = "www.awsref.kubecloud.net"
        "resource_record_name" = "_1aea94242136fa013a7d35752ffc146c.www.awsref.kubecloud.net."
        "resource_record_type" = "CNAME"
        "resource_record_value" = "_7418a7bdd7e339fcd681137257e4f771.rprhmdzstb.acm-validations.aws."
      },
    ])
    "early_renewal_duration" = ""
    "id" = "arn:aws:acm:ap-northeast-1:391178969547:certificate/55cda95d-693a-43da-a011-ea0b45f82e43"
    "key_algorithm" = "RSA_2048"
    "not_after" = "2024-10-14T23:59:59Z"
    "not_before" = "2023-09-15T00:00:00Z"
    "options" = tolist([
      {
        "certificate_transparency_logging_preference" = "ENABLED"
      },
    ])
    "pending_renewal" = false
    "private_key" = (sensitive value)
    "renewal_eligibility" = "INELIGIBLE"
    "renewal_summary" = tolist([])
    "status" = "ISSUED"
    "subject_alternative_names" = toset([
      "www.awsref.kubecloud.net",
    ])
    "tags" = tomap({
      "Name" = "ssl-cert"
    })
    "tags_all" = tomap({
      "Name" = "ssl-cert"
    })
    "type" = "AMAZON_ISSUED"
    "validation_emails" = tolist([])
    "validation_method" = "DNS"
    "validation_option" = toset([])
  },
]
```
I want this:
```
{
    "awsref.kubecloud.net": "arn:aws:acm:ap-northeast-1:391178969547:certificate/2933fa9b-0c9f-47e0-961c-cf2dfe090016",
    "www.awsref.kubecloud.net": "arn:aws:acm:ap-northeast-1:391178969547:certificate/55cda95d-693a-43da-a011-ea0b45f82e43",
}
```


```hcl
module "acm_route53" {
  source = "../../"

  create = true
  domain_names = [
    "awsref.kubecloud.net",
    "www.awsref.kubecloud.net",
  ]
  ...
  ...
}
...
...
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.7.0"

  create_lb          = true
  load_balancer_type = "application"
  ...

  target_groups = [...]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = module.acm_route53.domain_certificate_arns["awsref.kubecloud.net"] #<------------
      action_type        = "forward"
      target_group_index = 0
    }
  ]

  ...
  ...
}

```
