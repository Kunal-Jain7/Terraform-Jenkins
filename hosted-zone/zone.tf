data "aws_route53_zone" "jenkins-route53" {
  name         = "kunaldevopsproject.co.in"
  private_zone = false
}
resource "aws_route53_record" "lb-record" {
  zone_id = data.aws_route53_zone.jenkins-route53.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.aws_lb_dns_name
    zone_id                = var.aws_lb_zone_id
    evaluate_target_health = true
  }
}