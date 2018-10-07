
module "environment" {
  source = "../modules/ecs-environment"
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
  application = "${var.application}-lb"
  environment = "${var.environment}"
  owner = "${var.owner}"
  vpc_id = "vpc-66f4ef02"
  public_subnets = ["subnet-0eefab78", "subnet-3af8b007", "subnet-d741cddb"]
  health_check_path = "/version"
}

module "service" {
  source = "../modules/ecs-fargate-service"
  region = "${var.region}"
  profile = "${var.profile}"
  application = "${var.application}-service"
  environment = "${var.environment}"
  owner = "${var.owner}"
  vpc_id = "vpc-66f4ef02"
  private_subnets = ["subnet-15821f4d", "subnet-d53456b0", "subnet-e661f4cc"]
  cluster_id = "${module.environment.cluster_id}"
  execution_role_arn = "${module.environment.execution_role_arn}"
  load_balancer_target_group_arn = "${module.load_balancer.target_group_arn}"
  load_balancer_security_group_id = "${module.load_balancer.security_group_id}"
  task_definition = "${data.template_file.task_definition.rendered}"
}
