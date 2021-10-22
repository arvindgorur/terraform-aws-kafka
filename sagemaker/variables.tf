variable "instance_name" {
  description = "Name of the notebook instance"
  type        = string
}

# variable "role_name" {
#   description = "Name of the role to be attached to the notebook instance"
#   type        = string
# }

variable "instance_type" {
  description = "Compute type for the notebook instance"
  type        = string
}

variable "volume_size" {
  description = "Volume size for the notebook instance ins GB"
  type        = number
  default     = 100
}

variable "subnet_id" {
  description = "Subnet to run the notebook instance in"
  type        = string
  default     = "value"
}

variable "security_groups" {
  description = "Security groups associated with the notebook instance"
  type        = list(string)
  default     = []
}

variable "root_access" {
  description = "Specifies whether root access is enabled for usres of the notebook instance"
  type        = string
  default     = "Enabled"
  validation {
    condition = contains([
      "Enabled",
      "Disabled"
    ], var.root_access)
    error_message = "The root_access value should be either 'Enabled' or 'Disabled'."
  }
}

variable "direct_internet_access" {
  description = "Specifies whether the instance has internet access. If disabled, the instance can only access resources in the VPC"
  type        = string
  default     = "Disabled"
  validation {
    condition = contains([
      "Enabled",
      "Disabled"
    ], var.direct_internet_access)
    error_message = "The direct_internet_access value should be either 'Enabled' or 'Disabled'."
  }
}

variable "default_code_repository" {
  description = "The Git repo associated with the notebook instance as its default code repository"
  type        = string
  default     = null
}

variable "code_repository_name" {
  description = "Name for the SageMaker code repo to be created"
  type        = string
  default = null
}

variable "repository_url" {
  description = "URL of the Git repo to be attached to the notebook instance"
  type        = string
  default = null
}

variable "secret_arn" {
  description = "ARN of the secret containing credentials to access the repo"
  type        = string
  default     = ""
}

variable "lc_start_script" {
  description = "Script to be launched when a notebook instance is started"
  type        = string
  default     = <<CONFIG
#!/bin/bash
sudo ip route del 0.0.0.0/0 via 172.16.0.1 dev eth0
sudo ip route add 0.0.0.0/0 via 172.20.4.1 dev eth2
sudo ip route add 172.30.7.0/25 via 172.20.4.1 dev eth2
sudo ip route add 172.30.0.0/16 via 172.20.4.1 dev eth2
sudo aws cp s3://hoopp-isg-it4i-sw-store/jupyter-configs/on-start.sh /tmp/on-start.sh
sudo chmod +x /tmp/on-start.sh
/tmp/on-start.sh
CONFIG
}

variable "lc_create_script" {
  description = "Script to be launched when a notebook instance is created"
  type        = string
  default     = <<CONFIG
#!/bin/bash
sudo ip route add 172.30.7.0/25 via 172.20.4.1 dev eth2
sudo ip route add 172.30.0.0/16 via 172.20.4.1 dev eth2
sudo aws cp s3://hoopp-isg-it4i-sw-store/jupyter-configs/on-create.sh /tmp/on-create.sh
sudo chmod +x /tmp/on-create.sh
/tmp/on-create.sh
CONFIG
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

variable "custom_tags" {
  description = "Additional tags to add to the repo"
  type        = map(any)
  default     = {}
}

locals {
  notebook_tags = merge({
    Application = var.tag_application
    Team        = var.tag_team
    environment = var.environment
  }, var.custom_tags)
}
