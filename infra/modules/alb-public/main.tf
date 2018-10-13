resource "aws_lb" "alb" {
  name               = "${var.environment}-${var.application}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.security_group.id}"]
  subnets            = ["${var.public_subnets}"]

  enable_deletion_protection = false

  tags {
    application = "${var.application}"
    environment = "${var.environment}"
    owner = "${var.owner}"
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "${var.environment}-${var.application}"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
  target_type = "ip"

  health_check {
    interval = "6"
    path = "${var.health_check_path}"
    port = "80"
    protocol = "HTTP"
    timeout = "5"
    healthy_threshold = "2"
    unhealthy_threshold = "2"
  }

  tags {
    application = "${var.application}"
    environment = "${var.environment}"
    owner = "${var.owner}"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.target_group.arn}"
  }
}

resource "aws_security_group" "security_group" {
  name        = "${var.environment}-${var.application}"
  description = "Allow all inbound traffic"
  # description = "Access to the Load Balancer"
  vpc_id      = "${var.vpc_id}"

  tags {
    application = "${var.application}"
    environment = "${var.environment}"
    owner = "${var.owner}"
  }
}

resource "aws_security_group_rule" "internet_outbound" {
  security_group_id = "${aws_security_group.security_group.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "http_inbound" {
  security_group_id = "${aws_security_group.security_group.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
