resource "aws_iam_role" "sagemaker_instance_role" {
  name               = "${var.instance_name}-sagemaker-role"
  description        = "Allows SageMaker notebook instances to access services on your behalf."
  assume_role_policy = data.aws_iam_policy_document.sagemaker_assume_role.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonAthenaFullAccess",
    "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonTextractFullAccess"
  ]
  inline_policy {
    name   = "CodeCommitAccess"
    policy = data.aws_iam_policy_document.sagemaker-codecommit-access.json
  }
  inline_policy {
    name   = "S3Access"
    policy = data.aws_iam_policy_document.sagemaker-s3-access.json
  }
  inline_policy {
    name   = "SecretsAccess"
    policy = data.aws_iam_policy_document.sagemaker-secrets-access.json
  }
}

data "aws_iam_policy_document" "sagemaker-codecommit-access" {
  statement {
    actions = [
      "codecommit:Create*",
      "codecommit:DeleteBranch",
      "codecommit:DeleteFile",
      "codecommit:Describe*",
      "codecommit:Get*",
      "codecommit:List*",
      "codecommit:Merge*",
      "codecommit:OverridePullRequestApprovalRules",
      "codecommit:Put*",
      "codecommit:Post*",
      "codecommit:TagResource",
      "codecommit:Test*",
      "codecommit:UntagResource",
      "codecommit:Update*",
      "codecommit:GitPull",
      "codecommit:GitPush"
    ]
    resources = ["*"]
    sid       = "CodeCommitAccess"
  }
}

data "aws_iam_policy_document" "sagemaker-s3-access" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket"
    ]
    resources = ["arn:aws:s3:::*"]
    sid       = "S3Access"
  }
}

data "aws_iam_policy_document" "sagemaker-secrets-access" {
  statement {
    actions = [
      "secretsmanager:List*",
      "secretsmanager:Get*",
      "secretsmanager:Describe*"
    ]
    resources = ["*"]
    sid       = "SecretsAccess"
  }
}
