resource "aws_instance" "jenkins-instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = "Jenkins_terraform_Mac_Ireland"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.sg_for_jenkins
  associate_public_ip_address = var.enable_public_ip_address

  user_data = var.user_data_install_jenkins

  tags = {
    Name = format("jenkins-terraform-%s", var.stack_env)
  }
}