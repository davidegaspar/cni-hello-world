data "template_file" "execution_role" {
  template = "${file("${path.module}/execution-role.json")}"
}

data "template_file" "execution_policy" {
  template = "${file("${path.module}/execution-policy.json")}"
}
