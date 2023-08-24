## Request SSL/TLS Certficate

## Usage
```hcl
module "acm-route53" {
   
    source  = "shamimice03/acm-route53/aws"

    domain_name = "webapp.example.com"
    validation_method = "DNS"
    hosted_zone_name = "example.com"
    private_zone = false
    allow_record_overwrite = true
    ttl = 60
    tags = {
        "Name" = "ssl-cert"
    }

}
```


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.13.1 |

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
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Define Domain name | `string` | `""` | no |
| <a name="input_hosted_zone_name"></a> [hosted\_zone\_name](#input\_hosted\_zone\_name) | Define Hosted Zone Name | `string` | `""` | no |
| <a name="input_private_zone"></a> [private\_zone](#input\_private\_zone) | Determine Zone Type. `false` leads to `public zone` and `true` for `private zone` | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Define Tags | `map(any)` | <pre>{<br>  "Name": "ssl-cert"<br>}</pre> | no |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | Define ttl | `number` | `60` | no |
| <a name="input_validation_method"></a> [validation\_method](#input\_validation\_method) | Define Validation Method. `DNS` or `EMAIL` | `string` | `"DNS"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_certificate_arn"></a> [certificate\_arn](#output\_certificate\_arn) | certificate arn |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
