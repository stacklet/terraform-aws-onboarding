resource "aws_iam_role" "execution" {
  count = local.create_iam_resources ? 1 : 0

  name               = "${var.prefix}-execution"
  description        = "Execution for ${var.prefix} Stacklet deployment"
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.execution.json
}

data "aws_iam_policy_document" "execution" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [var.stacklet_execution_role_arn]
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.stacklet_deployment_id]
    }
  }
}

resource "aws_iam_role_policy_attachments_exclusive" "execution" {
  count = local.create_iam_resources ? 1 : 0

  role_name   = aws_iam_role.execution[0].name
  policy_arns = ["arn:${data.aws_partition.current.partition}:iam::aws:policy/ReadOnlyAccess"]
}

resource "aws_iam_role_policy" "execution_describe_augments" {
  count = local.create_iam_resources ? 1 : 0

  name   = "${var.prefix}-describe-augments"
  role   = aws_iam_role.execution[0].id
  policy = data.aws_iam_policy_document.describe_augments.json
}
