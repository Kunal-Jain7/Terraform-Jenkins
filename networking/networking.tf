# Terraform code for Creating New VPC and the required resources
resource "aws_vpc" "client-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = format("%s-%s", var.vpc_name, var.stack_env)
  }
}

# Setup for Public Subnet
resource "aws_subnet" "customize-client-pub-sub" {
  vpc_id            = aws_vpc.client-vpc.id
  count             = length(var.cidr_public_subnet)
  cidr_block        = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.eu_availibility_zone, count.index)

  tags = {
    Name = format("client-pub-sub-%s-${count.index + 1}", var.stack_env)
  }
}

# Setup for Private Subnet
resource "aws_subnet" "customize-client-prv-sub" {
  vpc_id            = aws_vpc.client-vpc.id
  count             = length(var.cidr_private_subnet)
  cidr_block        = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.eu_availibility_zone, count.index)

  tags = {
    Name = format("client-prv-sub-%s-${count.index + 1}", var.stack_env)
  }
}