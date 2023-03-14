variable "aws_region" {
  description = "The AWS region in which all resources will be created"
  type        = string
}

variable "aws_profile" {
  description = "The name of the AWS profile used to create resources"
  type        = string
}

variable "aws_account_id" {
  description = "The ID of the AWS Account in which to create resources"
  type        = string
}

variable "env_name" {
  description = "NC AWS Env: Intra, Direct, Staging, Prod"
}

variable "team" {
  description = "Team managing WAF rules."
  type        = string
  default     = "sre"
}
