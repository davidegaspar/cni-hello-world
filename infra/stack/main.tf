
module "cluster" {
  source = "../modules/ecs-cluster"
  region = "${var.region}"
  profile = "${var.profile}"
  application = "${var.application}"
  environment = "${var.environment}"
  owner = "${var.owner}"
}
