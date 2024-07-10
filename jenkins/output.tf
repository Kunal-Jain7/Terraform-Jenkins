output "ec2-instance-ip" {
  value = aws_instance.jenkins-instance.public_ip
}