#Password Policy

resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 14
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
  password_reuse_prevention      = 24
  max_password_age               = 90
}

module "policy" {
  source      = "../modules/policy"
  for_each    = toset(var.policies)
  name        = "AWS-${each.value}-${var.resource_suffix.iam_policy}"
  path        = "/"
  description = "This policy is for admins to have ${each.value}"
  policy      = "../modules/policy/json/${each.value}.json"
}