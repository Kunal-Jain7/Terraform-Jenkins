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

# Setup Internet Gateway
resource "aws_internet_gateway" "client-igw" {
  vpc_id = aws_vpc.client-vpc.id
  tags = {
    Name = format("client-igw-%s", var.stack_env)
  }
}

# Public Route Table
resource "aws_route_table" "client-route" {
  vpc_id = aws_vpc.client-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.client-igw.id
  }
  tags = {
    Name = format("client-public-route-%s", var.stack_env)
  }
}

# Public Route table and Public Subnet Association
resource "aws_route_table_association" "client-pub-rt-subnet-association" {
  count          = length(aws_subnet.customize-client-pub-sub)
  subnet_id      = aws_subnet.customize-client-pub-sub[count.index].id
  route_table_id = aws_route_table.client-route.id
}

# Private Route Table
resource "aws_route_table" "client-prv-route" {
  vpc_id = aws_vpc.client-vpc.id
  tags = {
    Name = format("client-prv-route-%s", var.stack_env)
  }
}

# Private route table and private Subnet Association
resource "aws_route_table_association" "client-prv-rt-subnet-association" {
  count          = length(aws_subnet.customize-client-prv-sub)
  subnet_id      = aws_subnet.customize-client-prv-sub[count.index].id
  route_table_id = aws_route_table.client-prv-route.id

}

