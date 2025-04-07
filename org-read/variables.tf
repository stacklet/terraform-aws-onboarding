variable "stacklet_assetdb_role_arn" {
  description = "ARN for the role used by AssetDB - Provided by Stacklet"
  type        = string
}

variable "stacklet_platform_role_arn" {
  description = "ARN for the role used by Platform - Provided by Stacklet"
  type        = string
}

variable "stacklet_deployment_id" {
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
