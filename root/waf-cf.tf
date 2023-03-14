# provider "aws" {
#   alias  = "cloudfront-global"
#   region = "us-east-1" // NOTE: This needs to be us-east-1 for WAFv2 on scope CLOUDFRONT
# }

# resource "aws_wafv2_rule_group" "wafv2_cf_rule_group" {
#   provider = aws.cloudfront-global
#   capacity = 500
#   name     = "${var.domain}-cf-${var.environment}-${var.aws_region}-rule-group"
#   scope    = "CLOUDFRONT"

#   //Geo-location rule
#   rule {
#     name     = "geo-location-restriction"
#     priority = 21

#     action {
#       allow {}
#     }

#     statement {
#       geo_match_statement {
#         country_codes = ["IN", "PL", "NL", "GB", "BE"]
#       }
#     }

#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "geo-location-restriction"
#       sampled_requests_enabled   = true
#     }
#   }

#   rule {
#     name     = "block-country-global-trade-compliance"
#     priority = 0

#     action {
#       block {}
#     }

#     statement {
#       geo_match_statement {
#         country_codes = var.block_countrycodes
#       }
#     }

#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "block-country-global-trade-compliance"
#       sampled_requests_enabled   = true
#     }
#   }

#   //dynamic rule for HEADERS based filtering

#   dynamic "rule" {
#     for_each = var.HEADERS_MATCH
#     content {
#       name     = rule.value
#       priority = 1 + rule.key
#       action {
#         allow {}
#       }
#       statement {
#         byte_match_statement {
#           positional_constraint = "CONTAINS"
#           search_string         = rule.value
#           field_to_match {
#             uri_path {}
#           }
#           text_transformation {
#             priority = 0
#             type     = "LOWERCASE"
#           }
#         }
#       }

#       visibility_config {
#         cloudwatch_metrics_enabled = true
#         metric_name                = "${rule.value}-metric"
#         sampled_requests_enabled   = true
#       }
#     }
#   }

#   visibility_config {
#     cloudwatch_metrics_enabled = true
#     metric_name                = "${var.domain}-cf-${var.environment}-${var.aws_region}-rule-group-metric"
#     sampled_requests_enabled   = true
#   }
# }

# //Regional type of wacl for cloudfront

# resource "aws_wafv2_web_acl" "wafv2_cf_web_acl" {
#   provider    = aws.cloudfront-global
#   description = "This is wacl for cloudfront"
#   name        = "${var.domain}-cf-${var.environment}-${var.aws_region}-wacl"
#   scope       = "CLOUDFRONT"

#   default_action {
#       block {}
#   }

#   rule {
#     name     = "${var.domain}-cf-${var.environment}-${var.aws_region}-rule"
#     priority = 20

#     override_action {
#       none {}
#     }

#     statement {
#       rule_group_reference_statement {
#         arn = aws_wafv2_rule_group.wafv2_cf_rule_group.arn
#       }

#     }

#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "${var.domain}-cf-${var.environment}-${var.aws_region}-rule-group"
#       sampled_requests_enabled   = true
#     }
#   }

# #   tags = merge(local.common_tags,
# #     {
# #       Name = "${var.domain}-cf-${var.environment}-${var.aws_region}-wacl"
# #   })

#   visibility_config {
#     cloudwatch_metrics_enabled = true
#     metric_name                = "${var.domain}-cf-${var.environment}-${var.aws_region}-wacl-metric"
#     sampled_requests_enabled   = true
#   }
# }