############### Security Hub variables ######################################

variable "aws_standards_list" {
  description = "A list of standards to enable in the account"
  type        = list(string)
  default     = ["ruleset/cis-aws-foundations-benchmark/v/1.2.0"]
}

############## Common Configuration #################
variable "aws_region" {
  description = "AWS region to create the resources"
  type        = string
  default     = "us-east-1"
}

variable "username" {
  type = list(any)
  default = [
    "nishant.akhouri27@gmail.com"
  ]
}

variable "policies" {
  type = list(any)
  default = [
    "read-only",
    "full-access"
  ]
}

variable "resource_suffix" {
  description = "map of resource suffix"
  type        = map(any)
  default = {
    "vpc_suffix"                  = "vpc",
    "nacl_suffix"                 = "nacl",
    "igw_suffix"                  = "igw",
    "endpoint_suffix"             = "endpoint",
    "iam_group"                   = "iam-group",
    "iam_policy"                  = "iam-policy",
    "s3_suffix"                   = "s3",
    "endpoint_suffix"             = "endpoint",
    "cloudwatch_suffix"           = "cloudwatch",
    "ecs_suffix"                  = "ecs"
  }
}

# variable "HEADERS_MATCH" {
#   type    = list(string)
#   default = ["xyz"]
# }

# variable "bucket_name" {
#   type    = list(string)
#   default = ["Bucket_1"]
# }


############### SNS Topic Variables ########################################

variable "topic_name" {
  description = "SNS Topic name"
  type        = string
  default     = "cis_change_alarms"
}

variable "topic_subscription_type" {
  description = "SNS Topic name"
  type        = string
  default     = "email"
}

variable "account_id" {
  description = "AWS account Id"
  type        = string
  default     = "516434969528"
}

variable "resource_name_prefix" {
  description = "All the resources will be prefixed with this varible"
  default     = "aws-cis"
}

# SNS
variable sns_arn {
  description = "SNS for CIS notifications"
  type =  string
  default = "nishant.akhouri27@gmail.com"
}

# S3
variable s3_enabled {
  default = true
}

variable audit_log_bucket_custom_policy_json {
  default = ""
}

# AWS Config
variable config_enabled {
  default = true
}

variable include_global_resource_types {
  default = true
}

# CloudTrail
variable cloudtrail_log_group_name {
  description = "CloudTrail LogGroup name"
  type        = string
  default     = "New_logs"
}

variable "clodtrail_event_selector_type" {
  description = "Log type for event selectors"
  default     = "All"
}

variable aws_account_id {
  description = "AWS Account ID"
  type        = string
  default     = "516434969528"
}

variable region {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable cloudtrail_kms_policy {
  description = "KMS policy for Cloudtrail logs."
  default     = ""
}

# Alerting
variable alerting_enabled {
  description = "Enable alerting"
  default     = true
}

variable alarm_namespace {
  description = "Alarm metric namespace"
  default     = "CISBenchmark"
}

variable tags {
  default = {
    "key"   = "AWS_CIS_Benchmark"
    "value" = "1.2.0"
  }
}

# Password Policy
variable "iam_allow_users_to_change_password" {
  description = "Can users change their own password"
  default     = true
}

variable "iam_hard_expiry" {
  description = "Everyone needs hard reset for expired passwords"
  default     = true
}

variable "iam_require_uppercase_characters" {
  description = "Require at least one uppercase letter in passwords"
  default     = true
}

variable "iam_require_lowercase_characters" {
  description = "Require at least one lowercase letter in passwords"
  default     = true
}

variable "iam_require_symbols" {
  description = "Require at least one symbol in passwords"
  default     = true
}

variable "iam_require_numbers" {
  description = "Require at least one number in passwords"
  default     = true
}

variable "iam_minimum_password_length" {
  description = "Require minimum lenght of password"
  default     = 14
}

variable "iam_password_reuse_prevention" {
  description = "Prevent password reuse N times"
  default     = 24
}

variable "iam_max_password_age" {
  description = "Passwords expire in N days"
  default     = 90
}

variable "name" {
  type = list(any)
  default = [
    "nishant.akho27@gmail.com"
  ]
}

variable "ou_name" {
  type = string
  default = "apexon"
}

variable "HEADERS_MATCH" {
  type    = list(string)
  default = ["selmedia", "mngmedia"]
}

variable "environment" {
  type = string
  default = "dev"
}

variable "domain" {
  type = string
  default = "local"
}

variable "block_countrycodes" {
  type    = list(string)
  default = ["UA", "RU", "CU", "IR", "KP", "SY"]
}


## Create Variable for S3 Bucket Name
variable "my_s3_bucket" {
  description = "S3 Bucket name that we pass to S3 Custom Module"
  type = string
  default = "mybucket-epf1311"
}

## Create Variable for S3 Bucket Tags
variable "my_s3_tags" {
  description = "Tags to set on the bucket"
  type = map(string)
  default = {
    Terraform = "true"
    Environment = "dev"
    newtag1 = "Apexon"
    newtag2 = "Nishant"
  }
}

# variable "domain_name_search" {
#   description = "Domain name to be searched without wildcard"
#   type        = string
# }

# variable "hosted_zone_name" {
#   description = "Domain name to be searched without wildcard"
#   type        = string
# }