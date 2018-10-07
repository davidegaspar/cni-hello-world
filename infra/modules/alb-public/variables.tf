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

# configuration

variable "health_check_path" {
  type = "list"
}
