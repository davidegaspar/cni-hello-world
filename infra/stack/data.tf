data "template_file" "task_definition" {
  template = "${file("${path.module}/task-definition.json")}"

  vars {
    application = "${var.application}"
    environment = "${var.environment}"
    repository_url = "${var.repository_url}"
  }
}
