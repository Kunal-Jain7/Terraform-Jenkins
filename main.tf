terraform {
  backend "s3" {
    bucket = "terraform-jenkins-project"
    key    = "devops-project/jenkins/terraform.tfstate"
  }
}

module "networking" {
  source = "./networking"

  vpc_cidr             = local.vpc_cidr
  vpc_name             = local.vpc_name
  cidr_public_subnet   = local.cidr_public_subnet
  eu_availibility_zone = local.eu_availibility_zone
  cidr_private_subnet  = local.cidr_private_subnet
  stack_env            = local.stack_env
}