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