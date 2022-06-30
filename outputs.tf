output "sns_subscription_arn" {
  value = { for k, v in aws_sns_topic_subscription.pagerduty_subscription : k => v.arn }
}