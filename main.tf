# Generate certificates
resource "aws_acm_certificate" "cert" {
  count             = var.create ? length(var.domain_names) : 0
  domain_name       = var.domain_names[count.index]
  validation_method = var.validation_method

  lifecycle {
    create_before_destroy = true
  }
  tags = var.tags
}

# Retrieve hosted zone info
data "aws_route53_zone" "public_zone" {
  count        = var.create ? 1 : 0
  name         = var.hosted_zone_name
  private_zone = var.private_zone
}

# Certificate validation
resource "aws_route53_record" "validation" {
  for_each = {
    for cert in aws_acm_certificate.cert : cert.domain_name => {
      name   = tolist(cert.domain_validation_options)[0].resource_record_name
      record = tolist(cert.domain_validation_options)[0].resource_record_value
      type   = tolist(cert.domain_validation_options)[0].resource_record_type
    }
  }

  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
  allow_overwrite = var.allow_record_overwrite
  ttl             = var.ttl
  zone_id         = data.aws_route53_zone.public_zone[0].zone_id
}

locals {
  certificate_arns = {
    for cert in aws_acm_certificate.cert : cert.domain_name => cert.arn
  }

  fqdns = {
    for key, record in aws_route53_record.validation : key => record.fqdn
  }
}

resource "aws_acm_certificate_validation" "valid_cert" {
  count                   = var.create ? length(var.domain_names) : 0
  certificate_arn         = local.certificate_arns[var.domain_names[count.index]]
  validation_record_fqdns = [local.fqdns[var.domain_names[count.index]]]
}
