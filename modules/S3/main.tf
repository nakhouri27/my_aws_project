# Create S3 Bucket Resource
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  acl    = "public-read"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "PublicReadGetObject",
          "Effect": "Allow",
          "Principal": "*",
          "Action": [
              "s3:GetObject"
          ],
          "Resource": [
              "arn:aws:s3:::${var.bucket_name}/*"
          ]
      }
  ]
}  
EOF
  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  lifecycle_rule {
    id = "object-transition-rule"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    enabled = true
    expiration {
      days = 90
    }
  }

  tags          = var.tags
  force_destroy = false

}




# resource "aws_s3_bucket" "bucket" {
#   bucket = var.bucket_name
# }

# resource "aws_s3_bucket_acl" "bucket_acl" {
#   bucket = aws_s3_bucket.s3_bucket.id
#   acl    = "private"
# }

# resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {
#   bucket = aws_s3_bucket.s3_bucket.id

#   rule {
#     id = "log"

#     expiration {
#       days = 90
#     }

#     filter {
#       and {
#         prefix = "log/"

#         tags = {
#           rule      = "log"
#           autoclean = "true"
#         }
#       }
#     }

#     status = "Enabled"

#     transition {
#       days          = 30
#       storage_class = "STANDARD_IA"
#     }

#     transition {
#       days          = 60
#       storage_class = "GLACIER"
#     }
#   }

#   rule {
#     id = "tmp"

#     filter {
#       prefix = "tmp/"
#     }


#     status = "Enabled"
#   }
# }
