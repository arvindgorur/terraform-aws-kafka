data "aws_iam_policy_document" "sagemaker_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}

data "template_file" "on_create" {
  template = file("${path.module}/scripts/on-create.sh")

}

data "template_file" "on_start" {
  template = file("${path.module}/scripts/on-start.sh")  
}