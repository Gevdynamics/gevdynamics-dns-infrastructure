# =============================================================================
# AWS WorkMail Organization
# =============================================================================

# WorkMail doesn't support tags — use a provider alias without default_tags
provider "aws" {
  alias  = "no_default_tags"
  region = "us-east-1"
}

# Import existing WorkMail org created during initial setup
import {
  to = aws_workmail_organization.main
  id = "m-cbf793cbcaf946f2a2b39dd6a5d2b765"
}

resource "aws_workmail_organization" "main" {
  provider           = aws.no_default_tags
  organization_alias = var.workmail_alias
}
