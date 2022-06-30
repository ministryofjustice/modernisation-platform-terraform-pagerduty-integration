module "test_alerts" {
  source                    = "../../"
  sns_topics                = [aws_sns_topic.test_topic.name]
  pagerduty_integration_key = local.pagerduty_integration_keys["core_alerts_cloudwatch"]

  depends_on = [aws_sns_topic.test_topic]
}

resource "aws_sns_topic" "test_topic" {
  name = "test_topic"
}