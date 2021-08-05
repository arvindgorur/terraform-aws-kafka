output "msk_cluster_arn" {
  value       = aws_msk_cluster.msk_cluster.arn
  description = "MSK Cluster ARN"
}

# output "msk_config_arn" {
#   description = "MSK configuration ARN"
#   value = aws_msk_configuration.configuration[0].arn
# }

# output "msk_config_version" {
#   description = "MSK configuration version"
#   value = aws_msk_configuration.configuration[0].latest_revision
# }