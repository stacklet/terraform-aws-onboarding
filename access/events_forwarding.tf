resource "aws_cloudwatch_event_rule" "forward" {
  count = local.different_target_account ? 1 : 0

  name        = "${var.prefix}-event-forward"
  description = "Event forwarding for ${var.prefix} Stacklet deployment"
  event_pattern = jsonencode({
    "$or" = [
      # Matches for cloudtrail mode
      {
        detail-type = ["AWS API Call via CloudTrail"]
        detail = {
          eventSource = [
            {
              "anything-but" = ["sts.amazonaws.com"]
            }
          ],
          errorCode = [
            {
              exists = false
            }
          ],
          readOnly        = [false]
          managementEvent = [true]
        }
      },
      # Matches for all other modes
      {
        detail-type = [
          "AWS Console Sign In via CloudTrail",
          # ec2-instance-state mode
          "EC2 Instance State-change Notification",
          # guard duty mode
          "GuardDuty Finding",
          # phd mode
          "AWS Health Event",
          # asg-instance-state mode
          "EC2 Instance Launch Successful",
          "EC2 Instance Launch Unsuccessful",
          "EC2 Instance Terminate Successful",
          "EC2 Instance Terminate Unsuccessful",
          # hub-finding
          "Security Hub Findings - Imported",
          # hub-action
          "Security Hub Findings - Custom Action",
          "Security Hub Insight Results"
        ]
      }
    ]
  })
}

resource "aws_cloudwatch_event_target" "forward" {
  count = local.different_target_account ? 1 : 0

  target_id = "${var.prefix}-event-forward"
  rule      = aws_cloudwatch_event_rule.forward[0].name
  arn       = "arn:${data.aws_partition.current.partition}:events:${data.aws_region.current.name}:${var.deployment_account}:event-bus/default"
  role_arn  = aws_iam_role.forward[0].arn
}

# Event forwarding role

resource "aws_iam_role" "forward" {
  count = local.create_forward_role ? 1 : 0

  name               = "${var.prefix}-forward"
  description        = "Event forwarding for ${var.prefix} Stacklet deployment"
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.forward_assume.json
}

data "aws_iam_policy_document" "forward_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "forward" {
  count = local.create_forward_role ? 1 : 0

  name   = "PutEventsNetForward"
  role   = aws_iam_role.forward[0].id
  policy = data.aws_iam_policy_document.forward.json
}

data "aws_iam_policy_document" "forward" {
  statement {
    actions   = ["events:PutEvents"]
    resources = ["arn:${data.aws_partition.current.partition}:events:*:${var.deployment_account}:event-bus/default"]
  }
}
