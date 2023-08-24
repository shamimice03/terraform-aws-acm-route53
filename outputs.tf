output "certificate_arn" {
  description = "certificate arn"
  value       = aws_acm_certificate_validation.valid_cert.certificate_arn
}