resource "aws_ecs_service" "service" {

  # depends_on = ["aws_iam_role_policy.foo"]
  # iam_role = "${aws_iam_role.foo.arn}"

  name = "${var.environment}-${var.application}"
  cluster = "${var.cluster_id}"
  task_definition = "${aws_ecs_task_definition.fargate_task_definition.arn}"
  launch_type = "FARGATE"
  desired_count = "${var.desired_count}"
  deployment_maximum_percent = "${var.deployment_maximum_percent}"
  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  health_check_grace_period_seconds = "${var.health_check_grace_period_seconds}"

  network_configuration {
    subnets  = ["${var.public_subnets}"]
    security_groups = ["${aws_security_group.security_group.id}"]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = "${var.load_balancer_target_group_arn}"
    container_name   = "${var.environment}-${var.application}"
    container_port   = 80
  }

  # lifecycle {
  #   ignore_changes = ["desired_count"]
  # }
}

resource "aws_ecs_task_definition" "fargate_task_definition" {
  family = "${var.environment}-${var.application}"
  container_definitions = "${var.task_definition}"
  execution_role_arn = "${var.execution_role_arn}"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = "${var.cpu}"
  memory = "${var.memory}"
}

resource "aws_security_group" "security_group" {
  name        = "${var.environment}-${var.application}"
  description = "Access to the Fargate containers"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "load_balancer" {
  security_group_id = "${aws_security_group.security_group.id}"
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  source_security_group_id = "${var.load_balancer_security_group_id}"
}

resource "aws_security_group_rule" "containers" {
  security_group_id = "${aws_security_group.security_group.id}"
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  source_security_group_id = "${aws_security_group.security_group.id}"
}

resource "aws_security_group_rule" "internet" {
  security_group_id = "${aws_security_group.security_group.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
