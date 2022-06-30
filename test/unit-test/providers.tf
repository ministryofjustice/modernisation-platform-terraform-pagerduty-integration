provider "aws" {
  region = "eu-west-2"
  assume_role {
    role_arn = "arn:aws:iam::${local.environment_management.account_ids["testing-test"]}:role/MemberInfrastructureAccess"
  }
}

provider "aws" {
  alias                  = "modernisation-platform"
  region                 = "eu-west-2"
  skip_get_ec2_platforms = true
}