# aws

variable "region" {
  type = "string"
  default = "us-east-1"
}

variable "profile" {
  type = "string"
  default = "default"
}

# tags

variable "application" {
  type = "string"
  default = "helloworld"
}

variable "environment" {
  type = "string"
  default = "stack"
}

variable "owner" {
  type = "string"
  default = "team-rocket"
}

# interface

variable "repository_url" {
  type = "string"
  default = "963345548549.dkr.ecr.us-east-1.amazonaws.com/delivery-helloworld"
}

variable "vpc_id" {
  type = "string"
  default = "vpc-66f4ef02"
}

variable "public_subnets" {
  type = "list"
  default = ["subnet-0eefab78", "subnet-3af8b007", "subnet-d741cddb"]
}
