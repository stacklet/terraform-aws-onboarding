# Stacklet account access

This modules adds IAM roles and resources needed by Stacklet to operate on an
AWS account.

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
| [aws_cloudwatch_event_rule.forward](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.forward](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_role.discover](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/resources/iam_role) | resource |
| [aws_iam_role.execution](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/resources/iam_role) | resource |
| [aws_iam_role.forward](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.discover_describe_augments](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.execution_describe_augments](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.forward](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachments_exclusive.discover](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/resources/iam_role_policy_attachments_exclusive) | resource |
| [aws_iam_role_policy_attachments_exclusive.execution](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/resources/iam_role_policy_attachments_exclusive) | resource |
| [aws_arn.stacklet_assetdb_role_arn](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/data-sources/arn) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.describe_augments](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.discover_assume](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.execution_assume](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.forward](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.forward_assume](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/5.94.0/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | A path for IAM created IAM roles. If set, it must include leading and trailing slashes | `string` | `"/"` | no |
| <a name="input_iam_region"></a> [iam\_region](#input\_iam\_region) | Region where IAM resouces should be created created. If this doesn't match the current region, resources are not created. | `string` | `"us-east-1"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | An arbitrary prefix pretended to names of created resources | `any` | n/a | yes |
| <a name="input_stacklet_assetdb_role_arn"></a> [stacklet\_assetdb\_role\_arn](#input\_stacklet\_assetdb\_role\_arn) | ARN for the role used by AssetDB - Provided by Stacklet | `string` | n/a | yes |
| <a name="input_stacklet_event_bus_arn"></a> [stacklet\_event\_bus\_arn](#input\_stacklet\_event\_bus\_arn) | ARN for event bus used for event forwarding - Provided by Stacklet | `string` | n/a | yes |
| <a name="input_stacklet_execution_role_arn"></a> [stacklet\_execution\_role\_arn](#input\_stacklet\_execution\_role\_arn) | ARN for the role used by policies Execution - Provided by Stacklet | `string` | n/a | yes |
| <a name="input_stacklet_external_id"></a> [stacklet\_external\_id](#input\_stacklet\_external\_id) | ID of the Stacklet delpoyment to restrict what can assume the roles - Provided by Stacklet | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_discover_role"></a> [discover\_role](#output\_discover\_role) | ARN for the Stacklet collector role |
| <a name="output_execution_role"></a> [execution\_role](#output\_execution\_role) | ARN for the Stacklet execution role |
| <a name="output_forward_role"></a> [forward\_role](#output\_forward\_role) | ARN for the Stacklet forwarder role |
<!-- END_TF_DOCS -->
