variable "environment" {
  description = "Environment to run in.  Should be acceptance|staging|prod "
}

variable "project_name" {
  description = "Name of your project"
}

variable "tags" {
  type        = map(string)
  description = "(Optional) tags"
  default     = {}
}

variable "index_document" {
  default     = "index.html"
  description = "(Optional) Entry point for static site.  Defaults to index.html"
}

variable "error_document" {
  default     = "error.html"
  description = "(Optional) Error page for static site.  Defaults to error.html"
}

variable "routing_rules" {
  default     = ""
  description = "(Optional) Routing rules for static site.  See https://docs.aws.amazon.com/AmazonS3/latest/dev/how-to-page-redirect.html"
}

variable "domain" {
  description = "Full domain name for the static site"
}

variable "path_to_source_directory" {
  description = "Path the directory to sync contents to S3"
}

variable "acm_certificate_arn" {
  description = "ARN for the certificate used to serve the website"
}

variable "hosted_zone_id" {
  description = "ID for the hosted zone the domain is created"
}

variable "web_acl_id" {
  default     = ""
  description = "(Optional) WAF web acl ID to secure access to website"
}

