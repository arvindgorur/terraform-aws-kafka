resource "aws_msk_configuration" "configuration" {
  count             = var.kafka_config != null ? 1 : 0
  description       = var.config_description
  kafka_versions    = [var.kafka_version]
  name              = var.config_name != null ? var.config_name : var.cluster_name
  server_properties = var.kafka_config[0].server_properties
}