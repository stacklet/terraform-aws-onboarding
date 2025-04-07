resource "aws_iam_role" "discover" {
  count = local.create_iam_resources ? 1 : 0

  name               = "${var.prefix}-discover"
  description        = "Read-Only Resource Collection for ${var.prefix} Stacklet deployment"
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.discover_assume.json
}

data "aws_iam_policy_document" "discover_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [var.stacklet_assetdb_role_arn]
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.stacklet_external_id]
    }
  }
}

resource "aws_iam_role_policy_attachments_exclusive" "discover" {
  count = local.create_iam_resources ? 1 : 0

  role_name   = aws_iam_role.discover[0].name
  policy_arns = [data.aws_iam_policy.readonly_access.arn]
}

resource "aws_iam_role_policy" "discover_describe_augments" {
  count = local.create_iam_resources ? 1 : 0

  name   = "DescribeAugments"
  role   = aws_iam_role.discover[0].id
  policy = data.aws_iam_policy_document.describe_augments.json
}
