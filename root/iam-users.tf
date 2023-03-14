module "iam_user" {
  source                        = "../modules/IAM_user"
  create_user                   = true
  for_each                      = toset(var.username)
  name                          = each.value
  #pgp_key                       = "keybase:nishant_gpg"
  password_reset_required       = true
  create_iam_user_login_profile = false

}

# Group TF Definition
resource "aws_iam_group" "admingroup" {
  name = "admingroup"
}
resource "aws_iam_group" "readonlygroup" {
  name = "readonlygroup"
}

#Assign User to AWS Group
resource "aws_iam_group_membership" "admin-users" {
  name = "admin-users"
  users = ["nishant.akhouri27@gmail.com"]
  group = aws_iam_group.admingroup.name
}
resource "aws_iam_group_membership" "readonly-users" {
  name = "readonly-users"
  users = ["nishant.akhouri27@gmail.com"]
  group = aws_iam_group.readonlygroup.name
}

#Policy for AWS Group
resource "aws_iam_policy_attachment" "admin-users-attach" {
  name       = "admin-users-attach"
  groups     = [aws_iam_group.admingroup.name]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
resource "aws_iam_policy_attachment" "readonly-users-attach" {
  name       = "readonly-users-attach"
  groups     = [aws_iam_group.readonlygroup.name]
  policy_arn = "arn:aws:iam::308393840560:policy/AWS-read-only-iam-policy"
}
