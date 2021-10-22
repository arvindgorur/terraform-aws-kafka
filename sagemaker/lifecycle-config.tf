resource "aws_sagemaker_notebook_instance_lifecycle_configuration" "lc" {
  name      = "${var.instance_name}-lc"
  on_create = base64encode(var.lc_create_script)
  on_start  = base64encode(var.lc_start_script)
}