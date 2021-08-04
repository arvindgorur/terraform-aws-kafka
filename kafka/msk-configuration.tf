resource "aws_msk_configuration" "configuration" {
  count = var.server_properties != null ? 1 : 0
  kafka_versions = ["2.1.0"]
  name           = "configuration"

  server_properties = var.server_properties
}