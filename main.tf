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

module "securitygroup" {
  source = "./securitygroup"

  vpc_id    = module.networking.vpc_id
  stack_env = local.stack_env
}

module "jenkins" {
  source = "./jenkins"

  ami_id                    = local.ami_id
  instance_type             = local.instance_type
  subnet_id                 = tolist(module.networking.cidr_public_subnet)[0]
  sg_for_jenkins            = [module.securitygroup.jenkins-8080-id, module.securitygroup.jenkins-terraform-sg-id]
  enable_public_ip_address  = true
  user_data_install_jenkins = templatefile("./jenkins-runner-script/jenkins-installer.sh", {})
  stack_env                 = local.stack_env
}

module "lb_target_group" {
  source = "./lb-target-group"

  lb_target_group_port     = 8080
  lb_target_group_protocol = "HTTP"
  vpc_id                   = module.networking.vpc_id
  ec2_instance_id          = module.jenkins.ec2_instance_id
  stack_env                = local.stack_env
}