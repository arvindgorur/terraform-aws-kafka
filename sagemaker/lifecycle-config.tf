resource "aws_sagemaker_notebook_instance_lifecycle_configuration" "lc" {
  name      = "${var.instance_name}-lc"
  on_create = base64encode(local.on_create)
  on_start  = base64encode(local.on_start)
}