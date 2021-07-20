/**
 * # Managed Services Kafka
 *
 * This module creates an MSK cluster.
 *
 *
 */

# module "my_msk_cluster" {
#   source                 = "./kafka"
#   cluster_name           = "test-cluster"
#   client_subnets         = ["subnet-05b967347e42ac28a", "subnet-07d46ef63b7d95bbb"]
#   security_groups        = ["sg-0a877f4a96539ee14"]
#   number_of_broker_nodes = 2
#   #encryption_at_rest_kms_key_arn = "arn:aws:kms:us-east-1:960672390668:key/0dc1b9bb-f664-4750-b971-4aace262ee10"
#   environment        = "dev"
#   tag_application    = "my application"
#   tag_team           = "my team"
#   kafka_version      = "2.7.0"
#   instance_type      = "kafka.m5.large"
#   cloudwatch_enabled = true
#   log_group          = "MSK"
# }

resource "aws_kms_key" "kms_key" {
  description = "example"
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = "msk_broker_logs"
}

resource "aws_msk_cluster" "msk_cluster" {
  cluster_name           = "test-cluster"
  kafka_version          = "2.6.1"
  number_of_broker_nodes = 2

  broker_node_group_info {
    instance_type   = "kafka.m5.large"
    ebs_volume_size = 100
    client_subnets = [
      "subnet-0aa7679d7b0383a90",
      "subnet-008af3400812192fa"
    ]
    security_groups = ["sg-0221b6b9c02d3810a"]
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = aws_kms_key.kms_key.arn
    encryption_in_transit {
      client_broker = "TLS"
      in_cluster    = true
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.log_group.name
      }
    }
  }

  tags = {
    foo = "bar"
  }
}

output "zookeeper_connect_string" {
  value = aws_msk_cluster.msk_cluster.zookeeper_connect_string
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = aws_msk_cluster.msk_cluster.bootstrap_brokers_tls
}