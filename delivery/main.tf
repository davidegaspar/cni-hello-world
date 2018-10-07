resource "aws_ecr_repository" "repository" {
  name = "${var.environment}-${var.application}"
}
