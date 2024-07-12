output "ec2-instance-ip" {
  value = aws_instance.jenkins-instance.public_ip
}

output "ec2_instance_id" {
  value = aws_instance.jenkins-instance.id
}