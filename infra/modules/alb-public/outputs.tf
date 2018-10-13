output "load_balancer_full_name" {
  value = "app/stack-helloworld-lb/fcc18941c4dd9cae"
}

output "target_group_full_name" {
  value = "targetgroup/stack-helloworld-lb/b1922a9716d2608c"
}

output "target_group_arn" {
  value = "${aws_lb_target_group.target_group.arn}"
}

output "security_group_id" {
  value = "${aws_security_group.security_group.id}"
}

output "dns_name" {
  value = "${aws_lb.alb.dns_name}"
}
