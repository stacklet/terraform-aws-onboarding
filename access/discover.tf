resource "aws_iam_role" "discover" {
  count = local.create_iam_resources ? 1 : 0

  name               = "${var.prefix}-discover"
  description        = "Read-Only Resource Collection for ${var.prefix} Stacklet deployment"
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.discover.json
}

data "aws_iam_policy_document" "discover" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:${data.aws_partition.current.partition}:iam::${var.deployment_account}:role${var.deployment_iam_path}${var.deployment_prefix}-collector"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.deployment_external_id]
    }
  }
}

resource "aws_iam_role_policy_attachments_exclusive" "discover" {
  count = local.create_iam_resources ? 1 : 0

  role_name   = aws_iam_role.discover[0].name
  policy_arns = ["arn:${data.aws_partition.current.partition}:iam::aws:policy/ReadOnlyAccess"]
}

resource "aws_iam_role_policy" "discover_describe_augments" {
  count = local.create_iam_resources ? 1 : 0

  name   = "${var.prefix}-describe-augments"
  role   = aws_iam_role.discover[0].id
  policy = data.aws_iam_policy_document.describe_augments.json
}
