variable "deployment_account" {
  description = "A destination account ID provided by Stacklet. This account hosts Stacklet platform resources"
  type        = string
}

variable "deployment_prefix" {
  description = "A prefix provided by Stacklet, associated with resources in the destination account"
  type        = string
}

variable "deployment_iam_path" {
  description = "Path for IAM roles ARNs provided by Stacklet.  If set, it must include leading and trailing slashes"
  type        = string
  default     = "/"

  validation {
    condition     = startswith(var.deployment_iam_path, "/") && endswith(var.deployment_iam_path, "/")
    error_message = "IAM path must include leading and trailing slashes"
  }
}

variable "deployment_external_id" {
  description = "An ExternalId provided by Stacklet to restrict who can assume the roles and avoid the confused deputy issue"
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
  description = "Region for created IAM resouces. If this doesn't match"
  type        = string
  default     = "us-east-1"
}
