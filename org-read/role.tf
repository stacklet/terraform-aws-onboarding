resource "aws_iam_role" "org_read" {
  name               = "${var.prefix}-org-read"
  description        = "Access to read accounts information for ${var.prefix} Stacklet deployment"
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.org_read_assume.json
}

data "aws_iam_policy_document" "org_read_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        var.stacklet_assetdb_role_arn,
        var.stacklet_platform_role_arn,
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.stacklet_external_id]
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
