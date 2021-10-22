resource "aws_sagemaker_code_repository" "repo" {
  count = var.default_code_repository != null ? 1 : 0
  code_repository_name = var.code_repository_name

  git_config {
    repository_url = var.repository_url
    secret_arn     = var.secret_arn
  }
}