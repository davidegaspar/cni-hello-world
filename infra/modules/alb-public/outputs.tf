output "load_balancer_arn" {
  value = "${aws_lb.alb.arn}"
}

output "load_balancer_full_name" {
  value = "${replace(element(split(":", aws_lb.alb.arn), 5), "loadbalancer/", "")}"
}

output "target_group_arn" {
  value = "${aws_lb_target_group.target_group.arn}"
}

output "target_group_full_name" {
  value = "${element(split(":", aws_lb_target_group.target_group.arn), 5)}"
}

output "security_group_id" {
  value = "${aws_security_group.security_group.id}"
}

output "dns_name" {
  value = "${aws_lb.alb.dns_name}"
}
