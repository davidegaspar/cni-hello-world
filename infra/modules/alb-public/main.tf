resource "aws_security_group" "security_group" {
  name        = "${var.environment}-${var.application}"
  description = "Allow all inbound traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "alb" {
  name               = "${var.environment}-${var.application}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.security_group.id}"]
  subnets            = ["${var.public_subnets}"]

  enable_deletion_protection = true

  tags {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "${var.environment}-${var.application}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
  target_type = "ip"

  health_check {
    interval = "6"
    path = "${var.health_check_path}"
    port =
    protocol = "HTTP"
    timeout = "6"
    healthy_threshold = "2"
    unhealthy_threshold = "2"
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
