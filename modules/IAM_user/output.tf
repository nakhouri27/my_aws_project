output "iam_user_name" {
  description = "The user's name"
  value       = element(concat(aws_iam_user.aws_users.*.name, [""]), 0)
}

output "iam_user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = element(concat(aws_iam_user.aws_users.*.arn, [""]), 0)
}

output "iam_user_unique_id" {
  description = "The unique ID assigned by AWS"
  value       = element(concat(aws_iam_user.aws_users.*.unique_id, [""]), 0)
}

# output "iam_user_login_profile_key_fingerprint" {
#   description = "The fingerprint of the PGP key used to encrypt the password"
#   value       = element(concat(aws_iam_user_login_profile.profiles.*.key_fingerprint, [""]), 0)
# }

# output "iam_user_login_profile_encrypted_password" {
#   description = "The encrypted password, base64 encoded"
#   value       = element(concat(aws_iam_user_login_profile.profiles.*.encrypted_password, [""]), 0)
# }
