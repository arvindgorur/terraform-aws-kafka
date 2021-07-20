resource "aws_kms_key" "kms_key" {
  count               = var.use_dedicated_key ? 1 : 0
  description         = "KMS key for MSK cluster ${var.cluster_name}"
  enable_key_rotation = true
  tags = local.common_tags
}

resource "aws_kms_alias" "kms_key_alias" {
  count         = var.use_dedicated_key ? 1 : 0
  name          = "alias/msk-${var.cluster_name}-key"
  target_key_id = aws_kms_key.kms_key[0].key_id
}

resource "aws_msk_cluster" "msk_cluster" {
  cluster_name           = var.cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes

  broker_node_group_info {
    instance_type   = var.instance_type
    ebs_volume_size = var.ebs_volume_size
    client_subnets  = var.client_subnets
    security_groups = var.security_groups
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = var.use_dedicated_key ? aws_kms_key.kms_key[0].arn : null
    encryption_in_transit {
      client_broker = "TLS"
      in_cluster    = true
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = var.log_group
      }
    }
  }

  tags = local.common_tags
}