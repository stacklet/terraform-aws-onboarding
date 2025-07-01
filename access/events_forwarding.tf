resource "aws_cloudwatch_event_rule" "forward" {
  count = local.different_target_account ? 1 : 0

  name        = "${var.resource_prefix}-event-forward"
  description = "Event forwarding for ${var.resource_prefix} Stacklet deployment"
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

  target_id = "${var.resource_prefix}-event-forward"
  rule      = aws_cloudwatch_event_rule.forward[0].name
  arn       = local.stacklet_event_bus_arn
  role_arn  = aws_iam_role.forward[0].arn
}

# Event forwarding role

resource "aws_iam_role" "forward" {
  count = local.create_forward_role ? 1 : 0

  name               = "${var.resource_prefix}-forward"
  description        = "Event forwarding for ${var.resource_prefix} Stacklet deployment"
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
    actions = ["events:PutEvents"]
    resources = [
      provider::aws::arn_build(
        data.aws_partition.current.partition,
        "events",
        "*",
        var.stacklet_destination_account_id,
        "event-bus/default"
      )
    ]
  }
}
