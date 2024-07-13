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

module "loadBalancer" {
  source = "./loadBalancer"

  sg_enable_ssh_https             = module.securitygroup.jenkins-terraform-sg-id
  is_external                     = false
  lb_type                         = "application"
  subnet_ids                      = tolist(module.networking.cidr_public_subnet)
  lb_target_group_arn             = module.lb_target_group.lb-target-group-arn
  ec2_instance_id                 = module.jenkins.ec2_instance_id
  lb_listener_port                = 80
  lb_listener_protocol            = "HTTP"
  lb_listener_default_action      = "forward"
  lb_https_listener_port          = 443
  lb_https_listener_protocol      = "HTTPS"
  cert_manager_arn                = module.aws_certification_manager.jenkins_acm_arn
  lb_target_group_attachment_port = 8080
  stack_env                       = local.stack_env
}

module "hosted_zone" {
  source = "./hosted-zone"

  domain_name     = "jenkins.kunaldevopsproject.co.in"
  aws_lb_dns_name = module.loadBalancer.aws_lb_dns_name
  aws_lb_zone_id  = module.loadBalancer.aws_lb_zone_id
}

module "aws_certification_manager" {
  source = "./certificate-manager"

  domain_name    = "jenkins.kunaldevopsproject.co.in"
  hosted_zone_id = module.hosted_zone.hosted_zone_id
  stack_env      = local.stack_env

}