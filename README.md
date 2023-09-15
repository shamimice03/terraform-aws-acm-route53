## Request SSL/TLS Certficate

## Usage
```hcl
module "acm_route53" {
    source  = "shamimice03/acm-route53/aws"

    create = true
    domain_names = [
        "awsref.kubecloud.net",
        "www.awsref.kubecloud.net",
    ]
    hosted_zone_name       = "kubecloud.net"
    private_zone           = false
    validation_method      = "DNS"
    allow_record_overwrite = true
    ttl                    = 60
    tags = {
        "Name" = "ssl-cert"
    }
}
```

## How to use:
```hcl
module "acm_route53" {
  source = "shamimice03/acm-route53/aws"

  create = true
  domain_names = [
    "awsref.kubecloud.net",
    "www.awsref.kubecloud.net",
  ]
  
  # ... omitted
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.7.0"

  create_lb          = true
  load_balancer_type = "application"

  # skipped for brevity
  target_groups = [...]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = module.acm_route53.domain_certificate_arns["awsref.kubecloud.net"]  # <------ 
      action_type        = "forward"
      target_group_index = 0
    }
  ]

  # ... omitted
}
```
Details on #[/examples/complete/](./examples/)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.17.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.valid_cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.public_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_record_overwrite"></a> [allow\_record\_overwrite](#input\_allow\_record\_overwrite) | Determine Record Overwite | `bool` | `true` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls if certificate should be generated | `bool` | `true` | no |
| <a name="input_domain_names"></a> [domain\_names](#input\_domain\_names) | Define Domain name | `list(string)` | `[]` | no |
| <a name="input_hosted_zone_name"></a> [hosted\_zone\_name](#input\_hosted\_zone\_name) | Define Hosted Zone Name | `string` | `""` | no |
| <a name="input_private_zone"></a> [private\_zone](#input\_private\_zone) | Determine Zone Type. `false` leads to `public zone` and `true` for `private zone` | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Define Tags | `map(any)` | `{}` | no |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | Define ttl | `number` | `60` | no |
| <a name="input_validation_method"></a> [validation\_method](#input\_validation\_method) | Define Validation Method. `DNS` or `EMAIL` | `string` | `"DNS"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_certificate_arns"></a> [certificate\_arns](#output\_certificate\_arns) | certificate arns |
| <a name="output_domain_certificate_arns"></a> [domain\_certificate\_arns](#output\_domain\_certificate\_arns) | domain with certificate arn |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Outputs format:
```hcl
certificate_arns = [
  "arn:aws:acm:ap-northeast-1:...",
  "arn:aws:acm:ap-northeast-1:...",
]

domain_certificate_arns = {
  "awsref.kubecloud.net" = "arn:aws:acm:ap-northeast-1:..."
  "www.awsref.kubecloud.net" = "arn:aws:acm:ap-northeast-1:..."
}
```
