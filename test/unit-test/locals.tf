data "aws_secretsmanager_secret" "pagerduty_integration_keys" {
  provider = aws.testing-ci-user
  name     = "pagerduty_integration_keys"
}

data "aws_secretsmanager_secret_version" "pagerduty_integration_keys" {
  provider  = aws.testing-ci-user
  secret_id = data.aws_secretsmanager_secret.pagerduty_integration_keys.id
}

data "aws_secretsmanager_secret" "environment_management" {
  provider = aws.testing-ci-user
  name     = "environment_management"
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
