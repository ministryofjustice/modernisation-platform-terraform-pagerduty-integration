variable "pagerduty_integration_keys" {
  type = map(string)
  description = "Map of SNS topic names to their corresponding PagerDuty integration keys"
}
