variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "hello-lambda"
}

variable "lambda_runtime" {
  description = "Lambda runtime"
  type        = string
  default     = "python3.12"
}

variable "lambda_memory_mb" {
  description = "Memory allocated to the Lambda function in MB"
  type        = number
  default     = 128
}

variable "lambda_timeout_seconds" {
  description = "Lambda function timeout in seconds"
  type        = number
  default     = 10
}
