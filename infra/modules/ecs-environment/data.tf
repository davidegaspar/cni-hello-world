data "template_file" "execution_policy" {
  template = "${file("${path.module}/execution-policy.json")}"
}
