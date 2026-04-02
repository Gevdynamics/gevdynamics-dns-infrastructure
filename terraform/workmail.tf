# =============================================================================
# AWS WorkMail Organization
# =============================================================================
# WorkMail org created via CLI. Imported into terraform state by previous runs.
# AWS provider has a tags bug, so we keep the resource but ignore all changes.
#
# Organization ID: m-cbf793cbcaf946f2a2b39dd6a5d2b765
# Alias: gevdynamics
# Webmail: https://gevdynamics.awsapps.com/mail
# IMAP: imap.mail.us-east-1.awsapps.com:993

provider "aws" {
  alias  = "no_default_tags"
  region = "us-east-1"
}

resource "aws_workmail_organization" "main" {
  provider           = aws.no_default_tags
  organization_alias = var.workmail_alias

  lifecycle {
    ignore_changes = all
  }
}
