resource "aws_acm_certificate" "aws_project_2" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Environment = "dev"
  }

 }

 resource "aws_acm_certificate_validation" "aws_project_2" {
  certificate_arn         = aws_acm_certificate.aws_project_2.arn
  validation_record_fqdns = [for record in aws_route53_record.aws_project_2_cert : record.fqdn]
  depends_on = [
    aws_route53_record.aws_project_2_cert
  ]
}