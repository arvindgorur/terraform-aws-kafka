resource "aws_msk_configuration" "configuration" {
  kafka_versions = ["2.1.0"]
  name           = "configuration"

  server_properties = var.server_properties
}