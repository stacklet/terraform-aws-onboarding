resource "aws_iam_role" "execution" {
  count = local.create_iam_resources ? 1 : 0

  name               = "${var.prefix}-execution"
  description        = "Execution for ${var.prefix} Stacklet deployment"
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.execution_assume.json
}

data "aws_iam_policy_document" "execution_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [var.stacklet_execution_role_arn]
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.stacklet_external_id]
    }
  }
}

resource "aws_iam_role_policy_attachments_exclusive" "execution" {
  count = local.create_iam_resources ? 1 : 0

  role_name   = aws_iam_role.execution[0].name
  policy_arns = [data.aws_iam_policy.readonly_access.arn]
}

resource "aws_iam_role_policy" "execution_describe_augments" {
  count = local.create_iam_resources ? 1 : 0

  name   = "DescribeAugments"
  role   = aws_iam_role.execution[0].id
  policy = data.aws_iam_policy_document.describe_augments.json
}

# Additional user-provider roles to grant to execution
resource "aws_iam_role" "execution_extra" {
  for_each = local.execution_extra_roles

  name               = "${var.prefix}-execution-${each.key}"
  description        = "Execution for ${var.prefix} Stacklet deployment"
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.execution_assume.json
}

resource "aws_iam_role_policy" "execution_extra" {
  for_each = local.execution_extra_roles

  name   = "AllowedActions"
  role   = aws_iam_role.execution_extra[each.key].id
  policy = data.aws_iam_policy_document.execution_extra[each.key].json
}

data "aws_iam_policy_document" "execution_extra" {
  for_each = local.execution_extra_roles

  statement {
    actions   = each.value
    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachments_exclusive" "execution_extra" {
  for_each = local.execution_extra_roles

  role_name   = aws_iam_role.execution_extra[each.key].name
  policy_arns = [data.aws_iam_policy.readonly_access.arn]
}

resource "aws_iam_role_policy" "execution_extra_describe_augments" {
  for_each = local.execution_extra_roles

  name   = "DescribeAugments"
  role   = aws_iam_role.execution_extra[each.key].id
  policy = data.aws_iam_policy_document.describe_augments.json
}
