variable "sg_enable_ssh_https" {}

variable "is_external" {
  default = false
}

variable "lb_type" {}

variable "subnet_ids" {}

variable "lb_target_group_arn" {}

variable "ec2_instance_id" {}

variable "lb_listener_port" {}

variable "lb_listener_protocol" {}

variable "lb_listener_default_action" {}

variable "lb_https_listener_port" {}

variable "lb_https_listener_protocol" {}

variable "cert_manager_arn" {}

variable "lb_target_group_attachment_port" {}

variable "stack_env" {}

