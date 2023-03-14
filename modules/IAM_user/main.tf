resource "aws_iam_user" "aws_users" {
  name                 = var.name
  path                 = var.path
  permissions_boundary = var.permissions_boundary

}

