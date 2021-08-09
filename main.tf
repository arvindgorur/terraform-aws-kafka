/**
 * # Managed Services Kafka
 *
 * This module creates an MSK cluster.
 *
 *
 */
# resource "aws_msk_configuration" "my_config" {
#   kafka_versions = ["2.7.0"]
#   name           = "my-config"

#   server_properties = <<CONFIG
# auto.create.topics.enable=true
# delete.topic.enable=true
# max.incremental.fetch.session.cache.slots=9000
# CONFIG
# }

module "my_msk_cluster" {
  depends_on = [aws_msk_configuration.my_config]
  source                 = "./kafka"
  cluster_name           = "test-cluster"
  client_subnets         = ["subnet-01a06432b4cf37af1", "subnet-07a3a59db265caf45"]
  security_groups        = ["sg-097f8f90eb138879d"]
  number_of_broker_nodes = 2
  environment            = "dev"
  tag_application        = "my application"
  tag_team               = "my team"
  kafka_version          = "2.7.0"
  instance_type          = "kafka.m5.large"
  log_group              = "test-cluster-logs"
  create_log_group       = true
  use_dedicated_key      = true
  kafka_config = [
    {
      server_properties      = "max.incremental.fetch.session.cache.slots=2000"
      revision = 1
    }
  ]
}

/**

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
*/
