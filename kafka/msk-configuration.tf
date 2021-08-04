resource "aws_msk_configuration" "configuration" {
  count             = var.server_properties != null ? 1 : 0
  kafka_versions    = var.kafka_version
  name              = var.config_name
  server_properties = var.server_properties
}