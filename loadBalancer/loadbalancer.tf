resource "aws_lb" "jenkins-lb" {
  name               = format("jenkins-lb-%s", var.stack_env)
  internal           = var.is_external
  load_balancer_type = var.lb_type
  security_groups    = [var.sg_enable_ssh_https]
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = format("jenkins-lb-%s", var.stack_env)
  }
}

resource "aws_lb_target_group_attachment" "jenkins-target-group-attachment" {
  target_group_arn = var.lb_target_group_arn
  target_id        = var.ec2_instance_id
  port             = var.lb_target_group_attachment_port
}

resource "aws_lb_listener" "jenkins-lb-listener" {
  load_balancer_arn = aws_lb.jenkins-lb.arn
  port              = var.lb_listener_port
  protocol          = var.lb_https_listener_protocol
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.cert_manager_arn

  default_action {
    type             = var.lb_listener_default_action
    target_group_arn = var.lb_target_group_arn
  }
}

resource "aws_lb_listener" "jenkins-lb-https-listener" {
  load_balancer_arn = aws_lb.jenkins-lb.arn
  port              = var.lb_https_listener_port
  protocol          = var.lb_https_listener_protocol
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
  certificate_arn   = var.cert_manager_arn

  default_action {
    type             = var.lb_listener_default_action
    target_group_arn = var.lb_target_group_arn
  }
}