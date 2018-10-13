resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = "${var.max_capacity}"
  min_capacity       = "${var.min_capacity}"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  role_arn           = "${aws_iam_role.appautoscaling_role.arn}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_requests_policy" {
  name                    = "${var.environment}-${var.application}-requests"
  policy_type             = "TargetTrackingScaling"
  resource_id             = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension      = "ecs:service:DesiredCount"
  service_namespace       = "ecs"

  target_tracking_scaling_policy_configuration {
    target_value = "${var.request_count_per_target_per_minute}"
    disable_scale_in = "${var.disable_scale_in}"
    scale_in_cooldown = "${var.scale_in_cooldown}"
    scale_out_cooldown = "${var.scale_out_cooldown}"
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label = "${var.load_balancer_full_name}/${var.target_group_full_name}"
    }
  }

  depends_on = ["aws_appautoscaling_target.ecs_target"]
}

resource "aws_iam_role" "appautoscaling_role" {
  name = "${var.environment}-${var.application}"
  assume_role_policy = "${data.template_file.appautoscaling_assume_role.rendered}"
}

resource "aws_iam_role_policy" "appautoscaling_policy" {
  name  = "${var.environment}-${var.application}"
  role  = "${aws_iam_role.appautoscaling_role.id}"
  policy = "${data.template_file.appautoscaling_policy.rendered}"
}
