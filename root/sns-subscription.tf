resource "aws_sns_topic_subscription" "sns_email_subscription" {
  topic_arn = aws_sns_topic.sns.arn
  protocol  = "email"
  endpoint  = "nishant.akhouri27@gmail.com"

  depends_on = [
    aws_sns_topic.sns
  ]

}