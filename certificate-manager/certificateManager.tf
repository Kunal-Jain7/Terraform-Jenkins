/*resource "aws_acm_certificate" "jenkins_acm" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Environment = var.stack_env
  }

  lifecycle {
    create_before_destroy = false
  }
}
*/
data "aws_acm_certificate" "jenkins_acm" {
  domain   = var.domain_name
  statuses = ["ISSUED"]
}
/*
resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in data.aws_acm_certificate.jenkins_acm.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = var.hosted_zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}*/