resource "aws_sns_topic" "sns" {
  name = "EPF-${var.aws_region}-${var.topic_name}-${var.topic_subscription_type}-sns-topic"
}

resource "aws_sns_topic_policy" "sns_policy" {
  arn    = aws_sns_topic.sns.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json

  depends_on = [
    aws_sns_topic.sns
  ]
}

data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        var.account_id,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.sns.arn,
    ]

    sid = "__default_statement_ID"

  }
}
