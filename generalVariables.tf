locals {
  stack_env = terraform.workspace
  vpc_cidr = lookup(
    var.vpc_cidr,
    terraform.workspace,
    var.vpc_cidr[var.default_value],
  )
  vpc_name = lookup(
    var.vpc_name,
    terraform.workspace,
    var.vpc_name[var.default_value],
  )
  cidr_public_subnet = lookup(
    var.cidr_public_subnet,
    terraform.workspace,
    var.cidr_public_subnet[var.default_value],
  )
  cidr_private_subnet = lookup(
    var.cidr_private_subnet,
    terraform.workspace,
    var.cidr_private_subnet[var.default_value],
  )
  eu_availibility_zone = lookup(
    var.eu_availibility_zone,
    terraform.workspace,
    var.eu_availibility_zone[var.default_value],
  )
  instance_type = lookup(
    var.instance_type,
    terraform.workspace,
    var.instance_type[var.default_value],
  )
  ami_id = lookup(
    var.ami_id,
    terraform.workspace,
    var.ami_id[var.default_value],
  )
}

variable "default_value" {
  description = "This will be the default value defined for each variable"
  default     = "default"
}

variable "region" {
  default = "eu-west-1"
}

variable "vpc_cidr" {
  type        = map(string)
  description = "CIDR Range of the public subnet for the respective environment"
  default = {
    prod    = "13.0.0.0/16"
    preprod = "12.0.0.0/16"
    default = "11.0.0.0/16"
  }
}

variable "vpc_name" {
  description = "Name of the value for the respective environment"
  default = {
    default = "dev-project-jenkins-vpc"
  }
}

variable "cidr_public_subnet" {
  type        = map(list(string))
  description = "Public Subnet range"
  default = {
    prod    = ["13.0.1.0/24", "13.0.2.0/24"]
    preprod = ["12.0.1.0/24", "12.0.2.0/24"]
    default = ["11.0.1.0/24", "11.0.2.0/24"]
  }
}

variable "cidr_private_subnet" {
  type        = map(list(string))
  description = "Private Subnet range"
  default = {
    prod    = ["13.0.3.0/24", "13.0.4.0/24"]
    preprod = ["12.0.3.0/24", "12.0.4.0/24"]
    default = ["11.0.3.0/24", "11.0.4.0/24"]
  }
}

variable "eu_availibility_zone" {
  description = "Availability Zone details"
  type        = map(list(string))
  default = {
    prod    = [""]
    preprod = [""]
    default = ["eu-west-1a", "eu-west-1b"]
  }
}

variable "instance_type" {
  description = "Type of instance required for each environment"
  type        = map(string)
  default = {
    prod    = ""
    preprod = ""
    default = "t2.medium"
  }
}

variable "ami_id" {
  type = map(string)
  default = {
    prod    = ""
    preprod = ""
    default = "ami-0932dacac40965a65"
  }
}