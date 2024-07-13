output "aws_lb_dns_name" {
  value = aws_lb.jenkins-lb.dns_name
}

output "aws_lb_zone_id" {
  value = aws_lb.jenkins-lb.zone_id
}