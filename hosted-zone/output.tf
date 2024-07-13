output "hosted_zone_id" {
  value = data.aws_route53_zone.jenkins-route53.zone_id
}