# ----------------------------------------------------------------------------------------------------------------------
# Terraform
#
# Provisioning:
#      - Route53 record
#
# Made by Aleksandr Vishnevskiy
# ----------------------------------------------------------------------------------------------------------------------

resource "aws_route53_record" "alias_route53_record" {
  zone_id = data.aws_route53_zone.domain.zone_id # Replace with your zone ID
  name    = var.domain                           # Replace with your name/domain/subdomain
  type    = "A"

  alias {
    name                   = aws_alb.alb.dns_name
    zone_id                = aws_alb.alb.zone_id
    evaluate_target_health = true
  }
}


