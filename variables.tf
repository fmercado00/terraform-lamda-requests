variable "cost_center" {
  type        = string
  description = "Cost Center"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "project" {
  type        = string
  description = "Project"
}

variable "output_path" {
  description = "Path to function's deployment package into local filesystem. eg: /path/lambda_function.zip"
  default = "lambda_function.zip"
}

variable "distribution_pkg_folder" {
  description = "Folder name to create distribution files..."
  default = "lambda_dist_pkg"
}

variable "function_name" {
  default = "lambdaTestTemplate"
}