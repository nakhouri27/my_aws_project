resource "null_resource" "sync" {
  provisioner "local-exec" {
    command = "aws s3 sync ${var.path_to_source_directory} s3://${aws_s3_bucket.static_site_bucket.id} --delete --acl 'public-read'"
  }

  triggers = {
    always_run = timestamp()
  }

  depends_on = [aws_s3_bucket.static_site_bucket]
}

resource "aws_s3_bucket" "static_site_bucket" {
  bucket        = "static-site-${var.project_name}-${var.environment}"
  acl           = "public-read"
  force_destroy = true

  website {
    index_document = var.index_document
    error_document = var.error_document
    routing_rules  = var.routing_rules
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  tags = merge(
    var.tags,
    {
      "Environment" = var.environment
      "Project"     = var.project_name
    },
  )
}

resource "aws_cloudfront_distribution" "website_cdn" {
  enabled = true

  origin {
    origin_id   = "origin-bucket-${aws_s3_bucket.static_site_bucket.id}"
    domain_name = aws_s3_bucket.static_site_bucket.website_endpoint

    custom_origin_config {
      origin_protocol_policy = "http-only"
      http_port              = "80"
      https_port             = "443"
      origin_ssl_protocols   = ["TLSv1"]
    }
  }

  default_root_object = var.index_document

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "DELETE", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl          = "0"
    default_ttl      = "300"
    max_ttl          = "1200"
    target_origin_id = "origin-bucket-${aws_s3_bucket.static_site_bucket.id}"

    viewer_protocol_policy = "redirect-to-https"
    compress               = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }

  aliases = [var.domain]

  web_acl_id = var.web_acl_id

  tags = merge(
    var.tags,
    {
      "Environment" = var.environment
      "Project"     = var.project_name
    },
  )
}

resource "aws_route53_record" "www" {
  zone_id = var.hosted_zone_id
  name    = var.domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.website_cdn.domain_name
    zone_id                = aws_cloudfront_distribution.website_cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

