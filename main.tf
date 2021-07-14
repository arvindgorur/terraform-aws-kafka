/**
 * # Managed Services Kafka
 *
 * This module creates an MSK cluster.
 *
 *
 */

module "my_msk_cluster" {
    source = "./kafka"
    cluster_name = "test-cluster"
    client_subnets = ["subnet-0d197931bccaa49c1", "subnet-0b09f110686a4193d"]
    security_groups = ["sg-019acf359a817f363"]
    encryption_at_rest_kms_key_arn = "arn:aws:kms:us-east-1:960672390668:key/0dc1b9bb-f664-4750-b971-4aace262ee10"
    environment = "dev"
    tag_application = "my application"
    tag_team = "my team"
}