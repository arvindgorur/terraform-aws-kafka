resource "aws_cloudwatch_log_group" "log_group" {
  count = var.create_log_group ? 1 : 0
  name = var.log_group
  tags = local.common_tags
}
