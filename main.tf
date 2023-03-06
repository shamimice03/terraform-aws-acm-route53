resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = var.validation_method


  lifecycle {
    create_before_destroy = true
  }

  #tags = var.tags

}


data "aws_route53_zone" "public_zone" {
  name         = var.hosted_zone_name
  private_zone = var.determine_zone_type
}


resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = var.allow_record_overwrite # bool
  name            = each.value.name
  records         = [each.value.record]
  ttl             = var.ttl
  type            = each.value.type
  zone_id         = data.aws_route53_zone.public_zone.zone_id
}


resource "aws_acm_certificate_validation" "valid_cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
}