output "static_site_bucket_id" {
  value       = aws_s3_bucket.static_site_bucket.id
  description = "The bucket id for the website"
}

output "static_site_bucket_name" {
  value       = aws_s3_bucket.static_site_bucket.bucket
  description = "The bucket name for the website"
}

output "static_site_bucket_arn" {
  value       = aws_s3_bucket.static_site_bucket.arn
  description = "The ARN for the website"
}

output "static_site_website_endpoint" {
  value       = aws_s3_bucket.static_site_bucket.website_endpoint
  description = "The website endpoint URL"
}

output "static_site_website_domain" {
  value       = aws_s3_bucket.static_site_bucket.website_domain
  description = "The domain of the website endpoint"
}

output "static_site_hosted_zone_id" {
  value       = aws_s3_bucket.static_site_bucket.hosted_zone_id
  description = "The Route 53 Hosted Zone ID for this bucket's region"
}

output "static_site_public_endpoint" {
  value       = aws_route53_record.www.name
  description = "The website endpoint URL"
}

output "static_site_cloudfront_distribution_id" {
  value       = aws_cloudfront_distribution.website_cdn.id
  description = "ID of the cloudfront distribution"
}

