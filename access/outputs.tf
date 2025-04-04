output "discover_role" {
  description = "ARN for the Stacklet collector role"
  value       = local.create_iam_resources ? aws_iam_role.discover[0].arn : null
}

output "forward_role" {
  description = "ARN for the Stacklet forwarder role"
  value       = local.create_forward_role ? aws_iam_role.forward[0].arn : null
}

output "execution_role" {
  description = "ARN for the Stacklet execution role"
  value       = local.create_iam_resources ? aws_iam_role.execution[0].arn : null
}
