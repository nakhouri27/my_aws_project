module "security-hub" {
  source            = "cloudposse/security-hub/aws"
  version           = "0.9.0"
  enabled           = true
  enabled_standards = var.aws_standards_list
}

