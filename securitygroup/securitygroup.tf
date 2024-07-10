resource "aws_security_group" "jenkins-terraform-sg" {
  vpc_id      = var.vpc_id
  name        = format("jeknins-terraform-%s-sg", var.stack_env)
  description = "Enable the Port 22 and Port 80"

  ingress {
    description = "Allow remote SSH anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  ingress {
    description = "Allow HTTP from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  ingress {
    description = "Allow HTTP from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  egress {
    description = "Allowing outgoing request"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = format("jeknins-terraform-%s-sg", var.stack_env)
  }
}

resource "aws_security_group" "jenkins-port-8080" {
  name        = format("jenkins-port-%s-8080", var.stack_env)
  vpc_id      = var.vpc_id
  description = "Enabling the port 8080 for Jenkins"

  ingress {
    description = "Jenkins Default port 8080"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  tags = {
    Name = format("jenkins-port-%s-8080", var.stack_env)
  }
}