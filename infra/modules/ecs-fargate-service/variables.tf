# aws

variable "region" {
  type = "string"
}

variable "profile" {
  type = "string"
}

# tags

variable "application" {
  type = "string"
}

variable "environment" {
  type = "string"
}

variable "owner" {
  type = "string"
}

# interface

variable "vpc_id" {
  type = "string"
}

variable "public_subnets" {
  type = "list"
}

variable "cluster_id" {
  type = "string"
}

variable "task_definition" {
  type = "string"
}

variable "execution_role_arn" {
  type = "string"
}

variable "load_balancer_target_group_arn" {
  type = "string"
}

variable "load_balancer_security_group_id" {
  type = "string"
}

# configuration

variable "deployment_maximum_percent" {
  type = "string"
  default = "200"
}

variable "deployment_minimum_healthy_percent" {
  type = "string"
  default = "100"
}

variable "health_check_grace_period_seconds" {
  type = "string"
  default = "60"
}

variable "desired_count" {
  type = "string"
  default = "0"
}

variable "cpu" {
  type = "string"
  default = "256"
}

variable "memory" {
  type = "string"
  default = "512"
}
