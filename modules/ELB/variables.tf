variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "subnet_id" {
  description = "subnet id"
}

variable "common_tags" {
  description = "common tags"
  type        = map(any)
}

variable "alb_sg_name" {
  type        = string
  description = "alb sg name"
}

variable "alb_internal" {
  description = "type of alb public or private"
}

variable "vpc_id" {
  type        = string
  description = "vpc id"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "alb_suffix" {
  type    = string
  default = "alb"
}

variable "cluster_name" {
  type    = string
  default = "gecko"
}

variable "sg_suffix" {
  type    = string
  default = "sg"
}

variable "vpc_suffix" {
  type    = string
  default = "vpc"
}

variable "nacl_suffix" {
  type    = string
  default = "nacl"
}

variable "igw_suffix" {
  type    = string
  default = "igw"
}

variable "repository_suffix" {
  type    = string
  default = "repository"
}

variable "cluster_suffix" {
  type    = string
  default = "cluster"
}

variable "task_suffix" {
  type    = string
  default = "task"
}

variable "container_suffix" {
  type    = string
  default = "container"
}

variable "dynamodb_suffix" {
  type    = string
  default = "dynamodb"
}

variable "s3_suffix" {
  type    = string
  default = "s3"
}

variable "ecs_suffix" {
  type    = string
  default = "ecs"
}

variable "nlb_suffix" {
  type    = string
  default = "nlb"
}

variable "tg_suffix" {
  type    = string
  default = "tg"
}

variable "endpoint_suffix" {
  type    = string
  default = "endpoint"
}

variable "task_policy_suffix" {
  type    = string
  default = "task-policy"
}

variable "task_definition_suffix" {
  type    = string
  default = "task-definition"
}


variable "domain_name_search" {
  description = "Domain name to search in ACM"
  type        = string
}

variable "domain_name_security_policy" {
  description = "Domain certificate security policy"
  type        = string
  default     = "ELBSecurityPolicy-TLS-1-2-2017-01"
}

variable "aws_acm_certificate_arn" {
  description = "Domain name cert in ACM"
  type        = string
}
