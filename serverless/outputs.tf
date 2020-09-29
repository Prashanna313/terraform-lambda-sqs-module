###########
# Lambda Function
###########

output "lambda_function_arn" {
  description = "The ARN of the Lambda Function"
  value       = element(concat(aws_lambda_function.lambda_function.*.arn, [""]), 0)
}

output "lambda_function_name" {
  description = "The name of the Lambda Function"
  value       = element(concat(aws_lambda_function.lambda_function.*.function_name, [""]), 0)
}

output "lambda_function_last_modified" {
  description = "The date Lambda Function resource was last modified"
  value       = element(concat(aws_lambda_function.lambda_function.*.last_modified, [""]), 0)
}
###########
# SQS
###########

output "sqs_queue_arn" {
  value = element(concat(aws_sqs_queue.sqs_queue.*.arn, [""]), 0)
}

output "sqs_queue_name" {
  value = element(concat(aws_sqs_queue.sqs_queue.*.name, [""]), 0)
}

output "sqs_queue_url" {
  value = element(concat(aws_sqs_queue.sqs_queue.*.id, [""]), 0)
}

output "sqs_dlq_arn" {
  value = element(concat(aws_sqs_queue.sqs_dlq.*.arn, [""]), 0)
}

output "sqs_dlq_name" {
  value = element(concat(aws_sqs_queue.sqs_dlq.*.name, [""]), 0)
}

output "sqs_dlq_url" {
  value = element(concat(aws_sqs_queue.sqs_dlq.*.id, [""]), 0)
}