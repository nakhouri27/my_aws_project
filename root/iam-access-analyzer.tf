resource "aws_accessanalyzer_analyzer" "account_access_analyzer" {
  analyzer_name = "EPF_13"
  type          = "ACCOUNT"
}