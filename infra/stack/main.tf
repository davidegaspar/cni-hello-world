
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
  health_check_path = "/health"
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
  desired_count = 1
}

module "scaling" {
  source = "../modules/ecs-scaling"
  region = "${var.region}"
  profile = "${var.profile}"
  application = "${var.application}-scaling"
  environment = "${var.environment}"
  owner = "${var.owner}"
  cluster_name = "${module.environment.cluster_name}"
  service_name = "${module.service.name}"
  load_balancer_full_name = "${module.load_balancer.load_balancer_full_name}"
  target_group_full_name = "${module.load_balancer.target_group_full_name}"
}

output "a" {
  value = "${module.load_balancer.load_balancer_full_name}"
}
output "b" {
  value = "${module.load_balancer.target_group_full_name}"
}
