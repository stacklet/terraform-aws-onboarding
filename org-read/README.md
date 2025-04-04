# Account discovery access

This modules adds an IAM role to allow Stacklet to discovery accounts in the organization.

**Note**: this must be run in the root account for the organization.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.94.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.94.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.org_read](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.tags_read](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachments_exclusive.org_read](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/resources/iam_role_policy_attachments_exclusive) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.org_read](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.tags_read](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment_account"></a> [deployment\_account](#input\_deployment\_account) | A destination account ID provided by Stacklet. This account hosts Stacklet platform resources | `string` | n/a | yes |
| <a name="input_deployment_external_id"></a> [deployment\_external\_id](#input\_deployment\_external\_id) | An ExternalId provided by Stacklet to restrict who can assume the roles and avoid the confused deputy issue | `string` | n/a | yes |
| <a name="input_deployment_iam_path"></a> [deployment\_iam\_path](#input\_deployment\_iam\_path) | Path for IAM roles ARNs provided by Stacklet.  If set, it must include leading and trailing slashes | `string` | `"/"` | no |
| <a name="input_deployment_prefix"></a> [deployment\_prefix](#input\_deployment\_prefix) | A prefix provided by Stacklet, associated with resources in the destination account | `string` | n/a | yes |
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | A path for IAM created IAM roles. If set, it must include leading and trailing slashes | `string` | `"/"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | An arbitrary prefix pretended to names of created resources | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_org_read_role"></a> [org\_read\_role](#output\_org\_read\_role) | ARN for the Stacklet read accounts role |
<!-- END_TF_DOCS -->
