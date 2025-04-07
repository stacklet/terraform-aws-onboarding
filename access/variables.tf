variable "stacklet_assetdb_role_arn" {
  description = "ARN for the role used by AssetDB - Provided by Stacklet"
  type        = string
}

variable "stacklet_execution_role_arn" {
  description = "ARN for the role used by policies Execution - Provided by Stacklet"
  type        = string
}

variable "stacklet_event_bus_arn" {
  description = "ARN for event bus used for event forwarding - Provided by Stacklet"
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
  description = "Region where IAM resouces should be created created. If this doesn't match the current region, resources are not created."
  type        = string
  default     = "us-east-1"
}
