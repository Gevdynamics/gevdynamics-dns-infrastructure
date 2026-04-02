# =============================================================================
# AWS WorkMail Organization
# =============================================================================

# Import existing WorkMail org created during initial setup
import {
  to = aws_workmail_organization.main
  id = "m-cbf793cbcaf946f2a2b39dd6a5d2b765"
}

resource "aws_workmail_organization" "main" {
  alias = var.workmail_alias
}
