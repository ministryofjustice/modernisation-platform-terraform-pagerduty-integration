output "sns_subscription_arn" {
  value = module.test_alerts.sns_subscription_arn[*]
}