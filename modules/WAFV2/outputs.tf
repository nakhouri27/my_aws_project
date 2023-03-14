output "rule_group_arn" {
  description = "ARN of baseline rule group."
  value = aws_wafv2_rule_group.baseline.arn
}
