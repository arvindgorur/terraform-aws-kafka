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
  client_subnets         = ["subnet-0e5ab758f74b76c8a", "subnet-0b86d16bf42854704"]
  security_groups        = ["sg-0b526208abea4c670"]
  number_of_broker_nodes = 2
  #encryption_at_rest_kms_key_arn = "arn:aws:kms:us-east-1:960672390668:key/0dc1b9bb-f664-4750-b971-4aace262ee10"
  environment     = "dev"
  tag_application = "my application"
  tag_team        = "my team"
  kafka_version   = "2.7.0"
}