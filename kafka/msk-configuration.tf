resource "aws_msk_configuration" "configuration" {
  count             = var.use_custom_config ? 1 : 0
  description       = var.config_description
  kafka_versions    = var.config_kafka_versions
  name              = var.config_name != null ? var.config_name : var.cluster_name
  server_properties = var.kafka_config[0].server_properties
}