terraform {
  backend "s3" {
    bucket  = "stacklet-terraform-ci-backend"
    key     = "tfstate/dev/terraform-aws-onboarding/tfstate.json"
    region  = "us-east-2"
    profile = "Test-Runner"
  }

  required_version = "~> 1.11.3"
}

locals {
  resource_prefix = "atlantis-ci"
  regions         = ["us-east-1", "us-east-2"]

  # Use the QA deployment as target, to point to a different account.
  stacklet_external_id        = "b5748e1f-0fa5-47c2-b9e2-84108424dd6a"
  stacklet_assetdb_role_arn   = "arn:aws:iam::179874453562:role/qa-collector"
  stacklet_execution_role_arn = "arn:aws:iam::179874453562:role/qa-stacklet-execution"
  stacklet_platform_role_arn  = "arn:aws:iam::179874453562:role/qa-stacklet-platform"
}


module "access" {
  source = "./access"

  stacklet_assetdb_role_arn   = local.stacklet_assetdb_role_arn
  stacklet_execution_role_arn = local.stacklet_execution_role_arn
  stacklet_external_id        = local.stacklet_external_id

  resource_prefix = local.resource_prefix
  regions         = local.regions
}

module "org-read" {
  source = "./org-read"

  stacklet_assetdb_role_arn  = local.stacklet_assetdb_role_arn
  stacklet_platform_role_arn = local.stacklet_platform_role_arn
  stacklet_external_id       = local.stacklet_external_id

  resource_prefix = local.resource_prefix
}
