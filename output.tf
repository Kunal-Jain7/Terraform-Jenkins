output "vpc_id" {
  value = module.networking.vpc_id
}

output "map_cidr_public_subnet" {
  value = module.networking.cidr_public_subnet
}

output "map_cidr_private_subnet" {
  value = module.networking.cidr_private_subnet
}

output "jenkins-terraform-sg-id" {
  value = module.securitygroup.jenkins-terraform-sg-id
}

output "ec2-instance-map-ip" {
  value = module.jenkins.ec2-instance-ip
}

output "lb-target-group-arn" {
  value = module.lb_target_group.lb-target-group-arn
}