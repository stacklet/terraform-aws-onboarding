locals {
  create_iam_resources     = data.aws_region.current.name == var.iam_region
  different_target_account = data.aws_caller_identity.current.account_id != var.deployment_account
  create_forward_role      = local.create_iam_resources && local.different_target_account
}
