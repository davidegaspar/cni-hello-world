resource "aws_route53_zone" "zone" {
  name = "${var.name}"
}

resource "aws_route53_record" "record" {
  count   = "${length(var.records)}"
  zone_id = "${var.zone_id}"
  name    = "${element(split(",",var.records[count.index]), 0)}"
  type    = "${element(split(",",var.records[count.index]), 1)}"
  alias {
    name = "${element(split(",",var.records[count.index]), 2)}"
    zone_id = "${element(split(",",var.records[count.index]), 3)}"
    evaluate_target_health = true
  }
}
