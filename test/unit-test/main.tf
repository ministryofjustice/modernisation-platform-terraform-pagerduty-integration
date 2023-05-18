module "test_alerts" {
  source                    = "../../"
  sns_topics                = [aws_sns_topic.test_alarms.name]
  pagerduty_integration_key = local.pagerduty_integration_keys["test_alarms"]
  depends_on                = [aws_sns_topic.test_alarms]
}

resource "aws_sns_topic" "test_alarms" {
  #checkov:skip=CKV_AWS_26:"encrypted topics do not work with pagerduty subscription"
  name = "test_alarms"
}