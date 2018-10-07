
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
  vpc_id = "${var.vpc_id}"
  public_subnets = ["${var.public_subnets}"]
  health_check_path = "/"
}

module "service" {
  source = "../modules/ecs-fargate-service"
  region = "${var.region}"
  profile = "${var.profile}"
  application = "${var.application}-service"
  environment = "${var.environment}"
  owner = "${var.owner}"
  vpc_id = "${var.vpc_id}"
  public_subnets = ["${var.public_subnets}"]
  cluster_id = "${module.environment.cluster_id}"
  execution_role_arn = "${module.environment.execution_role_arn}"
  load_balancer_target_group_arn = "${module.load_balancer.target_group_arn}"
  load_balancer_security_group_id = "${module.load_balancer.security_group_id}"
  task_definition = "${data.template_file.task_definition.rendered}"
  desired_count = 0
}
