provider "aws" {
  region = "us-east-2"
}

# resource "null_resource" "install_python_dependencies" {
#   provisioner "local-exec" {
#     command = "bash ${path.module}/scripts/create_pkg.sh"

#     environment = {
#       source_code_path = "code"
#       function_name = "lambdaTestTemplate"
#       path_module = path.module
#       runtime = "python3.9"
#       path_cwd = path.cwd
#     }
#   }
# }

data "archive_file" "python_lambda_package" {
  # depends_on = [null_resource.install_python_dependencies]
  source_dir = "${path.cwd}/lambda_dist_pkg/"
  type        = "zip"
  # source_file = "./code/lambda_function.py"
  output_path = "lambda_function.zip"
}

/*
  Create the lamda function
*/
resource "aws_lambda_function" "simplification_lambda_function" {
  function_name = "lambdaTestTemplate"

  filename         = "lambda_function.zip"
  # filename = data.archive_file.create_dist_pkg.output_path
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  role             = aws_iam_role.lambda_role.arn
  runtime          = "python3.9"
  handler          = "lambda_function.lambda_handler"
  timeout          = 10

  # depends_on = [null_resource.install_python_dependencies]


  environment {
    variables = {
      AWSREGION             = "us-east-2"
      SPEED_ALERT_THRESHOLD = "45"
    }
  }

  tags = {
    cost_center = var.cost_center
    environment = var.environment
    project     = var.project
  }

}
