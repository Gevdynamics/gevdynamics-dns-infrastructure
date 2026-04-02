# =============================================================================
# Route 53 Hosted Zone
# =============================================================================

# Import existing hosted zone created by Route 53 Registrar
import {
  to = aws_route53_zone.main
  id = "Z05053491TH6I10JF6NKU"
}

resource "aws_route53_zone" "main" {
  name = var.domain

  tags = merge(local.common_tags, {
    Name = var.domain
  })
}

# =============================================================================
# MX Record — WorkMail email receiving
# =============================================================================

resource "aws_route53_record" "mx" {
  zone_id = aws_route53_zone.main.zone_id
  name    = ""
  type    = "MX"
  ttl     = 3600
  records = ["10 inbound-smtp.us-east-1.amazonaws.com"]
}

# =============================================================================
# Autodiscover — email client auto-configuration
# =============================================================================

resource "aws_route53_record" "autodiscover" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "autodiscover"
  type    = "CNAME"
  ttl     = 300
  records = ["autodiscover.mail.us-east-1.awsapps.com"]
}

# =============================================================================
# SES Domain Ownership Verification
# =============================================================================

resource "aws_route53_record" "ses_verification" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "_amazonses"
  type    = "TXT"
  ttl     = 300
  records = ["4JbU0NChawq1TygNEsyvgL7uS3erbpaZtkciZ77godc="]
}

# =============================================================================
# SPF — authorizes Amazon SES to send on behalf of domain
# =============================================================================

resource "aws_route53_record" "spf" {
  zone_id = aws_route53_zone.main.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 300
  records = ["v=spf1 include:amazonses.com ~all"]
}

# =============================================================================
# DMARC — email authentication policy
# =============================================================================

resource "aws_route53_record" "dmarc" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = 300
  records = ["v=DMARC1;p=quarantine;pct=100;fo=1"]
}

# =============================================================================
# DKIM — cryptographic email signing (3 CNAME records from WorkMail/SES)
# =============================================================================

resource "aws_route53_record" "dkim_1" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "kq6vpvb6m5myjij74tsnlai2zzl5yuql._domainkey"
  type    = "CNAME"
  ttl     = 1800
  records = ["kq6vpvb6m5myjij74tsnlai2zzl5yuql.dkim.amazonses.com"]
}

resource "aws_route53_record" "dkim_2" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "3cknjjbxsqaps3grzrg6afpaddiydhpl._domainkey"
  type    = "CNAME"
  ttl     = 1800
  records = ["3cknjjbxsqaps3grzrg6afpaddiydhpl.dkim.amazonses.com"]
}

resource "aws_route53_record" "dkim_3" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "e6ywx4odqwspz6yh6dmvukdvjd3bevxh._domainkey"
  type    = "CNAME"
  ttl     = 1800
  records = ["e6ywx4odqwspz6yh6dmvukdvjd3bevxh.dkim.amazonses.com"]
}
