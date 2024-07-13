output "jenkins_acm_arn" {
  value = data.aws_acm_certificate.jenkins_acm.arn
}