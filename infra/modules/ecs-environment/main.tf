resource "aws_ecs_cluster" "cluster" {
  name = "${var.environment}-${var.application}"
}

resource "aws_iam_role" "execution_role" {
  name = "${var.environment}-${var.application}-execution"

  assume_role_policy = <<EOF
{
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "execution_policy" {
  name  = "${var.environment}-${var.application}-execution"
  role  = "${aws_iam_role.execution_role.id}"
  policy = "${data.template_file.execution_policy.rendered}"
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = "/aws/fargate/${var.environment}"
}
