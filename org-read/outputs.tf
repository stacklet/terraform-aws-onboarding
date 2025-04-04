output "org_read_role" {
  description = "ARN for the Stacklet read accounts role"
  value       = aws_iam_role.org_read.arn
}
