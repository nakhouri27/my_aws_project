output "aws_org_root_id" {
  description = "Root Organization Id."
  value       = data.aws_organizations_organization.aws.roots[0].id
}

output "aws_org_root_arn" {
  description = "Root Organization ARN."
  value       = data.aws_organizations_organization.aws.roots[0].arn
}

output "aws_ou_apexon_id" {
  description = "Root Organization Id."
  value       = aws_organizations_organizational_unit.apexon.id
}

output "aws_ou_apexon_arn" {
  description = "Root Organization ARN."
  value       = aws_organizations_organizational_unit.apexon.arn
}
