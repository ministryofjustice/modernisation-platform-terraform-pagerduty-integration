module "test_alerts" {
  source                    = "../../"
  sns_topics                = [aws_sns_topic.test_alarms.name]
  pagerduty_integration_key = local.pagerduty_integration_keys["low_priority_alarms"]
  depends_on                = [aws_sns_topic.test_alarms]
}

resource "aws_sns_topic" "test_alarms" {
  name = "test_alarms"
}