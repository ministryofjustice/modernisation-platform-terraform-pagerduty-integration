output "sns_subscription_arn" {
  value = { for k, v in aws_sns_topic_subscription.pagerduty_subscription : k => v.arn }
}

output "sns_topic_arn" {
  value = { for k, v in data.aws_sns_topic.alarm_topics : k => v.arn}
}