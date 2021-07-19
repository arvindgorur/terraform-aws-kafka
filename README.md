# MSK Cluster

This module creates an MSK cluster.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.50.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_msk_cluster.msk_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_subnets"></a> [client\_subnets](#input\_client\_subnets) | List of subnets to connect to in the VPC | `list(string)` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the MSK cluster | `string` | n/a | yes |
| <a name="input_ebs_volume_size"></a> [ebs\_volume\_size](#input\_ebs\_volume\_size) | EBS volume size of the cluster in GB | `number` | `100` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Provide appropriate environment name | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Cluster Instance type | `string` | `"kafka.m5.large"` | no |
| <a name="input_kafka_version"></a> [kafka\_version](#input\_kafka\_version) | Kafka version | `string` | `"2.6.1"` | no |
| <a name="input_number_of_broker_nodes"></a> [number\_of\_broker\_nodes](#input\_number\_of\_broker\_nodes) | The number of broker nodes to create | `number` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | List of security group IDs to be associated with the cluster to control access | `list(string)` | n/a | yes |
| <a name="input_encryption_at_rest_kms_key_arn"></a> [encryption\_at\_rest\_kms\_key\_arn](#input\_encryption\_at\_rest\_kms\_key\_arn) | ARN of the KMS key to use to encrypt data at rest. If no key is specified, the default AWS managed key for KMS will be used | `string` | `"null"` | no |
| <a name="input_cloudwatch_enabled"></a> [cloudwatch\_enabled](#input\_cloudwatch\_enabled) | Specifies whether broker logs should be sent to cloudwatch | `bool` | `"false"` | no |
| <a name="input_log_group"></a> [log\_group](#input\_log\_group) | The log group to send the broker logs to | `string` | `"null"` | no |
| <a name="input_tag_application"></a> [tag\_application](#input\_tag\_application) | Application tag | `string` | n/a | yes |
| <a name="input_tag_team"></a> [tag\_team](#input\_tag\_team) | Team tag | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_msk_cluster_arn"></a> [msk\_cluster\_arn](#output\_msk\_cluster\_arn) | MSK Cluster ARN |
