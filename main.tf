# Look up the existing hosted zone — we do NOT manage it.
data "aws_route53_zone" "shared" {
  name         = var.zone_name
  private_zone = false
}

resource "aws_route53_record" "a_record" {
  zone_id = data.aws_route53_zone.shared.zone_id
  name    = "${var.student_name}.${var.zone_name}"
  type    = "A"
  ttl     = var.record_ttl
  records = ["192.0.2.42"]
}

resource "aws_route53_record" "cname_www" {
  zone_id = data.aws_route53_zone.shared.zone_id
  name    = "www.${var.student_name}.${var.zone_name}"
  type    = "CNAME"
  ttl     = var.record_ttl
  records = ["${var.student_name}.${var.zone_name}"]
}

resource "aws_route53_record" "mx_record" {
  zone_id = data.aws_route53_zone.shared.zone_id
  name    = "${var.student_name}.${var.zone_name}"
  type    = "MX"
  ttl     = var.record_ttl
  records = ["10 mail.example.com."]
}

locals {
  guestbook = {
    quote    = "The best way to predict the future is to invent it."
    song     = "Never gonna give you up, never gonna let you down"
    shoutout = "Hello from ${var.student_name} at Ironhack!"
  }
}

resource "aws_route53_record" "guestbook" {
  for_each = local.guestbook

  zone_id = data.aws_route53_zone.shared.zone_id
  name    = "${each.key}.guestbook.${var.student_name}.${var.zone_name}"
  type    = "TXT"
  ttl     = var.record_ttl
  records = [each.value]
}

output "your_records" {
  value = {
    a_record  = aws_route53_record.a_record.fqdn
    cname     = aws_route53_record.cname_www.fqdn
    mx        = aws_route53_record.mx_record.fqdn
    guestbook = { for k, r in aws_route53_record.guestbook : k => r.fqdn }
  }
}