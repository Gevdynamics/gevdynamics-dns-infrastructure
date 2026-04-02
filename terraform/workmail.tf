# =============================================================================
# AWS WorkMail Organization
# =============================================================================
# WorkMail org is managed outside terraform (via MCP workmail_setup tool).
# The AWS terraform provider has a bug with tags on aws_workmail_organization
# that causes "inconsistent result after apply" errors.
#
# Organization ID: m-cbf793cbcaf946f2a2b39dd6a5d2b765
# Alias: gevdynamics
# Webmail: https://gevdynamics.awsapps.com/mail
# IMAP: imap.mail.us-east-1.awsapps.com:993

# Keep the provider alias so terraform can remove the orphaned resource from state
provider "aws" {
  alias  = "no_default_tags"
  region = "us-east-1"
}

# Remove the WorkMail org from terraform state without destroying it
removed {
  from = aws_workmail_organization.main

  lifecycle {
    destroy = false
  }
}
