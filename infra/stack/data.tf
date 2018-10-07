data "template_file" "task_definition" {
  template = "${file("${path.module}/task-definition.json")}"

  vars {
    region = "${var.region}"
    repository_url = "${var.repository_url}"
    environment = "${var.environment}"
    application = "${var.application}"
  }
}
