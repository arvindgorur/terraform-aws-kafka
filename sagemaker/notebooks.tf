# resource "aws_sagemaker_notebook_instance" "notebook" {
#   name                    = var.instance_name
#   role_arn                = aws_iam_role.sagemaker_instance_role.arn
#   instance_type           = var.instance_type
#   volume_size             = var.volume_size
#   subnet_id               = var.subnet_id
#   security_groups         = var.security_groups
#   lifecycle_config_name   = aws_sagemaker_notebook_instance_lifecycle_configuration.lc.name
#   root_access             = var.root_access
#   direct_internet_access  = var.direct_internet_access
#   default_code_repository = var.default_code_repository != null ? aws_sagemaker_code_repository.repo[0].code_repository_name : null

#   tags = merge(
#     local.notebook_tags
#   )
# }