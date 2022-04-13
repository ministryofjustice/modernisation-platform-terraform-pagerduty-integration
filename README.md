# Modernisation Platform Pagerduty Integration Terraform Module
[![repo standards badge](https://img.shields.io/badge/dynamic/json?color=blue&style=for-the-badge&logo=github&label=MoJ%20Compliant&query=%24.data%5B%3F%28%40.name%20%3D%3D%20%22modernisation-platform-terraform-pagerduty-integration%22%29%5D.status&url=https%3A%2F%2Foperations-engineering-reports.cloud-platform.service.justice.gov.uk%2Fgithub_repositories)](https://operations-engineering-reports.cloud-platform.service.justice.gov.uk/github_repositories#modernisation-platform-terraform-pagerduty-integration "Link to report")

Terraform module for associating SNS topics with PagerDuty services on the Modernisation Platform.

## Usage

```hcl

# Get the map of pagerduty integration keys from the modernisation platform account
data "aws_secretsmanager_secret" "pagerduty_integration_keys" {
  provider = aws.modernisation-platform
  name     = "pagerduty_integration_keys"
}

data "aws_secretsmanager_secret_version" "pagerduty_integration_keys" {
  provider  = aws.modernisation-platform
  secret_id = data.aws_secretsmanager_secret.pagerduty_integration_keys.id
}

# Add a local to get the keys
locals {
  pagerduty_integration_keys = jsondecode(data.aws_secretsmanager_secret_version.pagerduty_integration_keys.secret_string)
}

module "pagerduty_core_alerts" {
  source                    = "github.com/ministryofjustice/modernisation-platform-terraform-pagerduty-integration?ref=1.0"
  sns_topics                = ["config", "securityhub-alarms", "cloudtrail"]
  pagerduty_integration_key = local.pagerduty_integration_keys["core_alerts_cloudwatch"]
}

```

### Adding new PagerDuty sevices
New Pagerduty services can be added here - https://github.com/ministryofjustice/modernisation-platform/blob/main/terraform/pagerduty/services.tf

Once added the integration key should be added to the secret here - https://github.com/ministryofjustice/modernisation-platform/blob/main/terraform/pagerduty/aws.tf#L12

<!--- BEGIN_TF_DOCS --->


<!--- END_TF_DOCS --->

## Looking for issues?
If you're looking to raise an issue with this module, please create a new issue in the [Modernisation Platform repository](https://github.com/ministryofjustice/modernisation-platform/issues).
