variable "cluster_name" {
  description = "Name of the MSK cluster"
  type        = string
}

variable "config_name" {
  description = "Name of the MSK config"
  type        = string
  default     = null
}

variable "kafka_version" {
  description = "Kafka version"
  type        = string
  default     = "2.6.1"
}

variable "server_properties" {
  description = "Kafka server configuration properties"
  type = string
  default = null
}

variable "number_of_broker_nodes" {
  description = "The number of broker nodes to create"
  type        = number
}

variable "instance_type" {
  description = "Cluster Instance type"
  type        = string
  default     = "kafka.t3.small"
}

variable "ebs_volume_size" {
  description = "EBS volume size of the cluster in GB"
  type        = number
  default     = 100
}

variable "client_subnets" {
  description = "List of subnets to connect to in the VPC"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs to be associated with the cluster to control access"
  type        = list(string)
}

variable "encryption_at_rest_kms_key_arn" {
  description = "ARN of the KMS key to use to encrypt data at rest"
  type        = string
  default     = null
}

variable "create_log_group" {
  description = "Specifies whether or not to create a log group for the MSK cluster"
  type = bool
  default = false
}

variable "log_group" {
  description = "The log group to send the broker logs to"
  type        = string
}

variable "use_dedicated_key" {
  description = "Specify whether to use AWS managed or dedicated KMS key for encryption"
  type        = bool
  default     = false
}

variable "environment" {
  description = "Provide appropriate environment name"
  type        = string

  validation {
    condition = contains([
      "dev",
      "development",
      "uat",
      "production",
      "prod",
      "sandbox"
    ], var.environment)

    error_message = "The environment value is not valid. Valid values are dev/development/uat/prod/production/sandbox."
  }
}

variable "tag_application" {
  description = "Application tag"
  type        = string
}

variable "tag_team" {
  description = "Team tag"
  type        = string
}

locals {
  common_tags = {
    Application = var.tag_application
    Team        = var.tag_team
    environment = var.environment
  }
}

variable "config_description" {
  description = "Description of the broker configuration"
  type = string
  default = null
}
