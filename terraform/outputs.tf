output "hosted_zone_id" {
  description = "Route 53 hosted zone ID"
  value       = aws_route53_zone.main.zone_id
}

output "name_servers" {
  description = "Route 53 name servers"
  value       = aws_route53_zone.main.name_servers
}

output "workmail_organization_id" {
  description = "WorkMail organization ID"
  value       = aws_workmail_organization.main.organization_id
}

output "webmail_url" {
  description = "WorkMail webmail URL"
  value       = "https://${var.workmail_alias}.awsapps.com/mail"
}

output "imap_host" {
  description = "IMAP server for email clients"
  value       = "imap.mail.us-east-1.awsapps.com"
}
