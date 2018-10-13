output "cluster_id" {
  value = "${aws_ecs_cluster.cluster.id}"
}

output "cluster_name" {
  value = "${var.environment}-${var.application}"
}

output "execution_role_arn" {
  value = "${aws_iam_role.execution_role.arn}"
}
