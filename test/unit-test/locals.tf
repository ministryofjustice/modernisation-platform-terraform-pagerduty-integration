data "aws_secretsmanager_secret" "pagerduty_integration_keys" {
  provider = aws.testing-ci-user
  arn      = format("arn:aws:secretsmanager:eu-west-2:%s:secret:pagerduty_integration_keys-26WzqG", local.environment_management["modernisation_platform_account_id"])
}

data "aws_secretsmanager_secret_version" "pagerduty_integration_keys" {
  provider  = aws.testing-ci-user
  secret_id = data.aws_secretsmanager_secret.pagerduty_integration_keys.id
}

data "aws_ssm_parameter" "environment_management_arn" {
  provider = aws.testing-ci-user
  name     = "environment_management_arn"
}

data "aws_secretsmanager_secret" "environment_management" {
  provider = aws.testing-ci-user
  arn      = data.aws_ssm_parameter.environment_management_arn.value
}

# Get latest secret value with ID from above. This secret stores account IDs for the Modernisation Platform sub-accounts
data "aws_secretsmanager_secret_version" "environment_management" {
  provider  = aws.testing-ci-user
  secret_id = data.aws_secretsmanager_secret.environment_management.id
}

locals {
  environment_management     = jsondecode(data.aws_secretsmanager_secret_version.environment_management.secret_string)
  pagerduty_integration_keys = jsondecode(data.aws_secretsmanager_secret_version.pagerduty_integration_keys.secret_string)
}
