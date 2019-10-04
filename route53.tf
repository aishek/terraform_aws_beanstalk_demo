resource "aws_route53_zone" "site" {
  name = "${var.domain}."
}
data "aws_elastic_beanstalk_hosted_zone" "current" {}
resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.site.zone_id}"
  name    = "${var.domain}"
  type    = "A"

  alias {
    name                   = "${aws_elastic_beanstalk_environment.green.cname}"
    zone_id                = "${data.aws_elastic_beanstalk_hosted_zone.current.id}"
    evaluate_target_health = false
  }
}
