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
  description = "This is a dummy key"
  enable_key_rotation = true
}

resource "aws_kms_alias" "kms_key_alias" {
  name = "alias/some-key"
  target_key_id = aws_kms_key.kms_key.id
}