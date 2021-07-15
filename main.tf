/**
 * # Managed Services Kafka
 *
 * This module creates an MSK cluster.
 *
 *
 */

module "my_msk_cluster" {
  source                 = "./kafka"
  cluster_name           = "test-cluster"
  client_subnets         = ["subnet-0b1d4f755ec71824e", "subnet-0676b364b392f286e"]
  security_groups        = ["sg-0d2529b0efc1ad854"]
  number_of_broker_nodes = 2
  #encryption_at_rest_kms_key_arn = "arn:aws:kms:us-east-1:960672390668:key/0dc1b9bb-f664-4750-b971-4aace262ee10"
  environment     = "dev"
  tag_application = "my application"
  tag_team        = "my team"
  kafka_version   = "2.7.0"
  instance_type = "kafka.m5.large"
}