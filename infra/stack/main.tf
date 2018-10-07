
module "cluster" {
  source = "../modules/ecs-cluster"
  region = "${var.region}"
  profile = "${var.profile}"
  application = "${var.application}"
  environment = "${var.environment}"
  owner = "${var.owner}"
}

module "load_balancer" {
  source = "../modules/alb-public"
  region = "${var.region}"
  profile = "${var.profile}"
  application = "${var.application}"
  environment = "${var.environment}"
  owner = "${var.owner}"
  vpc_id = "vpc-66f4ef02"
  public_subnets = ["subnet-0eefab78", "subnet-3af8b007", "subnet-d741cddb"]
  health_check_path = "/version"
}

# module "service" {
#   source = "../modules/ecs-service"
#   region = "${var.region}"
#   profile = "${var.profile}"
#   application = "${var.application}"
#   environment = "${var.environment}"
#   owner = "${var.owner}"
#   vpc_id = "vpc-66f4ef02"
#   private_subnets = ["subnet-15821f4d", "subnet-d53456b0", "subnet-e661f4cc"]
#   cluster_id = "${module.cluster.id}"
#   task_definition = "${file("service.json")}"
# }
