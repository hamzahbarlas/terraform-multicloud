output "api_endpoint" {
  description = "Base URL of the API Gateway endpoint"
  value       = aws_apigatewayv2_stage.default.invoke_url
}

output "hello_url" {
  description = "Full URL for the /hello route"
  value       = "${aws_apigatewayv2_stage.default.invoke_url}/hello"
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.api.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.api.arn
}

output "iam_role_arn" {
  description = "ARN of the Lambda execution IAM role"
  value       = aws_iam_role.lambda.arn
}
