# Modernisation Platform Pagerduty Integration Terraform Module

[![Standards Icon]][Standards Link] [![Format Code Icon]][Format Code Link] [![Scorecards Icon]][Scorecards Link]

[![SCA Icon]][SCA Link] [![Terraform SCA Icon]][Terraform SCA Link]

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
  source                    = "github.com/ministryofjustice/modernisation-platform-terraform-pagerduty-integration?ref=0179859e6fafc567843cd55c0b05d325d5012dc4" # v2.0.0
  sns_topics                = ["config", "securityhub-alarms", "cloudtrail"]
  pagerduty_integration_key = local.pagerduty_integration_keys["core_alerts_cloudwatch"]
}

```

### Adding new PagerDuty sevices

New Pagerduty services can be added here - https://github.com/ministryofjustice/modernisation-platform/blob/main/terraform/pagerduty/services.tf

Once added the integration key should be added to the secret here - https://github.com/ministryofjustice/modernisation-platform/blob/main/terraform/pagerduty/aws.tf#L12

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name                                                                     | Version  |
| ------------------------------------------------------------------------ | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.0.1 |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | ~> 5.0   |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | ~> 5.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                                    | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_sns_topic_subscription.pagerduty_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource    |
| [aws_sns_topic.alarm_topics](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sns_topic)                                  | data source |

## Inputs

| Name                                                                                                         | Description | Type        | Default | Required |
| ------------------------------------------------------------------------------------------------------------ | ----------- | ----------- | ------- | :------: |
| <a name="input_pagerduty_integration_key"></a> [pagerduty_integration_key](#input_pagerduty_integration_key) | n/a         | `string`    | n/a     |   yes    |
| <a name="input_sns_topics"></a> [sns_topics](#input_sns_topics)                                              | n/a         | `list(any)` | n/a     |   yes    |

## Outputs

No outputs.

<!--- END_TF_DOCS --->

## Looking for issues?

If you're looking to raise an issue with this module, please create a new issue in the [Modernisation Platform repository](https://github.com/ministryofjustice/modernisation-platform/issues).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.20.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_sns_topic_subscription.pagerduty_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic.alarm_topics](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sns_topic) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_pagerduty_integration_key"></a> [pagerduty\_integration\_key](#input\_pagerduty\_integration\_key) | n/a | `string` | n/a | yes |
| <a name="input_sns_topics"></a> [sns\_topics](#input\_sns\_topics) | n/a | `list(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sns_subscription_arn"></a> [sns\_subscription\_arn](#output\_sns\_subscription\_arn) | n/a |
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | n/a |
<!-- END_TF_DOCS -->

[Standards Link]: https://github-community.cloud-platform.service.justice.gov.uk/repository-standards/modernisation-platform-terraform-pagerduty-integration 'Repo standards badge.'
[Standards Icon]: https://github-community.cloud-platform.service.justice.gov.uk/repository-standards/api/modernisation-platform-terraform-pagerduty-integration/badge
[Format Code Icon]: https://img.shields.io/github/actions/workflow/status/ministryofjustice/modernisation-platform-terraform-pagerduty-integration/format-code.yml?labelColor=231f20&style=for-the-badge&label=Formate%20Code
[Format Code Link]: https://github.com/ministryofjustice/modernisation-platform-terraform-pagerduty-integration/actions/workflows/format-code.yml
[Scorecards Icon]: https://img.shields.io/github/actions/workflow/status/ministryofjustice/modernisation-platform-terraform-pagerduty-integration/scorecards.yml?branch=main&labelColor=231f20&style=for-the-badge&label=Scorecards
[Scorecards Link]: https://github.com/ministryofjustice/modernisation-platform-terraform-pagerduty-integration/actions/workflows/scorecards.yml
[SCA Icon]: https://img.shields.io/github/actions/workflow/status/ministryofjustice/modernisation-platform-terraform-pagerduty-integration/code-scanning.yml?branch=main&labelColor=231f20&style=for-the-badge&label=Secure%20Code%20Analysis
[SCA Link]: https://github.com/ministryofjustice/modernisation-platform-terraform-pagerduty-integration/actions/workflows/code-scanning.yml
[Terraform SCA Icon]: https://img.shields.io/github/actions/workflow/status/ministryofjustice/modernisation-platform-terraform-pagerduty-integration/code-scanning.yml?branch=main&labelColor=231f20&style=for-the-badge&label=Terraform%20Static%20Code%20Analysis
[Terraform SCA Link]: https://github.com/ministryofjustice/modernisation-platform-terraform-pagerduty-integration/actions/workflows/terraform-static-analysis.yml
