# get hosted zone details
#terraform aws data hosted zone
data "aws_route53_zone" "aws_project_2" {
    name = var.fqdn
    private_zone = false
  }
# cretae a record set in route 53
# terraform aws route 53 record 
/*
resource "aws_route53_record" "aws_project_2" {
  zone_id = data.aws_route53_zone.aws_project_2.zone_id
  name    = var.record_name
  type    = "A"
  
  
  alias {
   name                   = aws_elb.main.dns_name
  zone_id                = data.aws_route53_zone.aws_project_2.zone_id
    evaluate_target_health = true
  }
}
*/

 resource "aws_route53_record" "aws_project_2_cert" {
  for_each = {
    for dvo in aws_acm_certificate.aws_project_2.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.aws_project_2.zone_id
}
