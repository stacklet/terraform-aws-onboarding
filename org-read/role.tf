resource "aws_iam_role" "org_read" {
  name               = "${var.prefix}-org-read"
  description        = "Access to read accounts information for ${var.prefix} Stacklet deployment"
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.org_read.json
}

data "aws_iam_policy_document" "org_read" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:${data.aws_partition.current.partition}:iam::${var.deployment_account}:role${var.deployment_iam_path}${var.deployment_prefix}-collector",
        "arn:${data.aws_partition.current.partition}:iam::${var.deployment_account}:role${var.deployment_iam_path}${var.deployment_prefix}-stacklet-platform",
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.deployment_external_id]
    }
  }
}

resource "aws_iam_role_policy_attachments_exclusive" "org_read" {
  role_name   = aws_iam_role.org_read.name
  policy_arns = ["arn:${data.aws_partition.current.partition}:iam::aws:policy/AWSOrganizationsReadOnlyAccess"]
}

resource "aws_iam_role_policy" "tags_read" {
  name   = "AllowBulkTagRead"
  role   = aws_iam_role.org_read.id
  policy = data.aws_iam_policy_document.tags_read.json
}

data "aws_iam_policy_document" "tags_read" {
  statement {
    actions   = ["tag:GetResources"]
    resources = ["*"]

  }
}
