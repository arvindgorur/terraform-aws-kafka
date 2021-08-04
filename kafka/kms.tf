/*
resource "aws_kms_key" "kms_key" {
  count               = var.use_dedicated_key ? 1 : 0
  description         = "KMS key for MSK cluster ${var.cluster_name}"
  enable_key_rotation = true
  tags = local.common_tags
}

resource "aws_kms_alias" "kms_key_alias" {
  count         = var.use_dedicated_key ? 1 : 0
  name          = "alias/msk-${var.cluster_name}-key"
  target_key_id = aws_kms_key.kms_key[0].key_id
}
*/