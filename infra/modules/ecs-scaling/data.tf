data "template_file" "appautoscaling_assume_role" {
  template = "${file("${path.module}/appautoscaling-assume-role.json")}"
}

data "template_file" "appautoscaling_policy" {
  template = "${file("${path.module}/appautoscaling-policy.json")}"
}
