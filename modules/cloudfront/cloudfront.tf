# Microfrontend S3 bucket
resource "aws_s3_bucket" "s3_frontend" {

  bucket = "${var.domain_naming_construct}-${var.environment}-${var.aws_region}-${var.business_scope}-${var.bucket_suffix}"
  acl    = "private"

  force_destroy = var.force_destroy

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = merge(var.common_tags,
    {
      Name = "${var.domain_naming_construct}-${var.environment}-${var.aws_region}-${var.business_scope}-${var.bucket_suffix}"
  })
}


resource "aws_s3_bucket_public_access_block" "s3_public_access_block" {

  bucket = aws_s3_bucket.s3_frontend.id

  #Blocks public access in S3 Cloudfront
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  depends_on = [
    aws_s3_bucket_policy.s3_access_policy
  ]
}

data "aws_iam_policy_document" "s3_policy" {

  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3_frontend.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.cf_access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "s3_access_policy" {
  bucket = aws_s3_bucket.s3_frontend.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

resource "aws_cloudfront_origin_access_identity" "cf_access_identity" {
  comment = "cloudfront origin access identity "
}

resource "aws_cloudfront_distribution" "s3_distribution" {

  origin {
    domain_name = aws_s3_bucket.s3_frontend.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.s3_frontend.bucket_regional_domain_name
    origin_path = var.origin_path

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cf_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "cloudfront distribution"
  default_root_object = "index.html"
  web_acl_id          = var.web_acl_arn == "" ? null : var.web_acl_arn

  # logging_config {
  #   include_cookies = false
  #   bucket          = "mylogs.s3.amazonaws.com"
  #   prefix          = "myprefix"
  # }

  aliases = ["${var.alternative_domain}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.s3_frontend.bucket_regional_domain_name

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Custom error response configuration
  custom_error_response {
    error_code         = var.error_code
    response_code      = var.response_code
    response_page_path = var.response_page_path
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/css/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = aws_s3_bucket.s3_frontend.bucket_regional_domain_name

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.s3_frontend.bucket_regional_domain_name

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_200"

  # GB For United Kingdom
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = var.countrycodes
    }
  }

  tags = merge(var.common_tags,
    {
      Name = "${var.domain_naming_construct}-${var.environment}-${var.aws_region}-${var.business_scope}-${var.cf_suffix}"
  })

  # Currently running on default certificate
  viewer_certificate {
    acm_certificate_arn = var.certificate_arn
    ssl_support_method  = var.ssl_method
  }
}
