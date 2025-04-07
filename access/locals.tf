data "aws_partition" "current" {}
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_arn" "stacklet_assetdb_role_arn" {
  arn = var.stacklet_assetdb_role_arn
}

locals {
  create_iam_resources     = data.aws_region.current.name == var.iam_region
  different_target_account = data.aws_caller_identity.current.account_id != data.aws_arn.stacklet_assetdb_role_arn.account
  create_forward_role      = local.create_iam_resources && local.different_target_account
}
