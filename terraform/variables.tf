variable "domain" {
  description = "Primary domain name"
  type        = string
  default     = "gevdynamics.com"
}

variable "workmail_alias" {
  description = "WorkMail organization alias (becomes <alias>.awsapps.com)"
  type        = string
  default     = "gevdynamics"
}
