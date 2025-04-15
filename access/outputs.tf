output "discover_role" {
  description = "ARN for the resource-discovery role assumed by Stacklet AssetDB"
  value       = local.create_iam_resources ? aws_iam_role.discover[0].arn : null
}

output "forward_role" {
  description = "ARN for the role used to forward cloud events to Stacklet"
  value       = local.create_forward_role ? aws_iam_role.forward[0].arn : null
}

output "execution_role" {
  description = "ARN for the default policy-execution role assumed by Stacklet Execution"
  value       = local.create_iam_resources ? aws_iam_role.execution[0].arn : null
}

output "execution_extra_roles" {
  description = "ARNs for extra policy-execution roles assumed by Stacklet Execution"
  value       = length(aws_iam_role.execution_extra) > 0 ? [for r in aws_iam_role.execution_extra : r.arn] : null
}
