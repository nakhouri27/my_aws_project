variable "aws_region" {
  description = "The AWS region in which all resources will be created"
  type        = string
  default = "eu-central-1"
}

variable "aws_profile" {
  description = "The name of the AWS profile used to create resources"
  type        = string
  default = "Nishant"
}

variable "aws_account_id" {
  description = "The ID of the AWS Account in which to create resources"
  type        = string
  default = "308393840560"
}

variable "env_name" {
  description = "Name of environment, used for tagging and naming."
  type        = string
  default = "null"
}

variable "team" {
  description = "Name of the team"
  type        = string
  default = ""
}

variable "app" {
  description = "Name of the app"
  type        = string
  default = ""
}

variable "service" {
  description = "Name of the service"
  type        = string
  default = ""
}