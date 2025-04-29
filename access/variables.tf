variable "stacklet_assetdb_role_arn" {
  description = "ARN for the role used by AssetDB - Provided by Stacklet"
  type        = string
}

variable "stacklet_execution_role_arn" {
  description = "ARN for the role used by policies Execution - Provided by Stacklet"
  type        = string
}

variable "stacklet_host_account_id" {
  description = "Destination account for event forwarding - Provided by Stacklet"
  type        = string
}

variable "stacklet_external_id" {
  description = "ID of the Stacklet delpoyment to restrict what can assume the roles - Provided by Stacklet"
  type        = string
}

variable "prefix" {
  description = "An arbitrary prefix pretended to names of created resources"
}

variable "iam_path" {
  description = "A path for IAM created IAM roles. If set, it must include leading and trailing slashes"
  type        = string
  default     = "/"

  validation {
    condition     = startswith(var.iam_path, "/") && endswith(var.iam_path, "/")
    error_message = "IAM path must include leading and trailing slashes"
  }
}

variable "iam_region" {
  description = "Region where IAM resouces should be created. If you don't use us-east-1, set this to a region you do use."
  type        = string
  default     = "us-east-1"
}

variable "execution_extra_roles" {
  description = <<-EOT
Additional roles to grant to Stacklet for policies execution.

If provided, this must be a map from the role name (which gets the prefix
prepended) and a list of permissions to grant to the role in addition to the
default read-only permissions.
EOT
  type        = map(list(string))
  default     = {}
}
