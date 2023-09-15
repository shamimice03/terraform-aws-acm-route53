output "certificate_arns" {
  description = "certificate arns"
  value       = try(aws_acm_certificate_validation.valid_cert[*].certificate_arn, null)
}

output "domain_certificate_arns" {
  description = "domain with certificate arn"
  value       = try(local.certificate_arns, null)
}
