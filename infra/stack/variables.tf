variable "region" {
  type = "string"
  default = "us-east-1"
}

variable "profile" {
  type = "string"
  default = "default"
}

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

variable "repository_url" {
  type = "string"
  default = "963345548549.dkr.ecr.us-east-1.amazonaws.com/delivery-helloworld"
}
