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

variable "cluster_name" {
  type = "string"
}

variable "service_name" {
  type = "string"
}

variable "load_balancer_full_name" {
  type = "string"
}

variable "target_group_full_name" {
  type = "string"
}

# configuration

variable "min_capacity" {
  type = "string"
  default = "1"
}

variable "max_capacity" {
  type = "string"
  default = "3"
}

variable "request_count_per_target_per_minute" {
  type = "string"
  default = "10"
}

variable "disable_scale_in" {
  type = "string"
  default = "false"
}

variable "scale_in_cooldown" {
  type = "string"
  default = "60"
}

variable "scale_out_cooldown" {
  type = "string"
  default = "0"
}
