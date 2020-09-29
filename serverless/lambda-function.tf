# create a Lambda function triggered by c4c-application-event-queue to get lead event data from C4C and its corresponding Lambda alias

resource "aws_lambda_function" "lambda_function" {
  count         = var.create_lambda ? var.lambda_count : 0
  function_name = var.lambda_name
  description   = var.lambda_description
  s3_bucket     = var.s3_bucket_name
  memory_size   = var.memory_size
  timeout       = var.timeout
  s3_key        = var.s3_bucket_key
  handler       = var.lambda_handler
  runtime       = var.runtime
  layers        = var.lambda_layers
  role          = aws_iam_role.lambda-exe-role[count.index].arn
  tracing_config {
    mode = "Active"
  }
  tags = {
    BusinessUnit    = var.BusinessUnit
    Environment     = var.env
    CostCenter      = var.CostCenter
    Product         = var.Product
    DataSensitivity = var.DataSensitivity
  }
  environment {
    variables = {
      stage = var.env
    }
  }

  dynamic "vpc_config" {
    for_each = var.vpc_subnet_ids != null && var.vpc_security_group_ids != null ? [true] : []
    content {
      security_group_ids = var.vpc_security_group_ids
      subnet_ids         = var.vpc_subnet_ids
    }
  }

}

resource "aws_lambda_alias" "lambda_function_alias" {
  count            = var.create_lambda ? var.lambda_count : 0
  name             = var.env
  description      = "Alias"
  function_name    = aws_lambda_function.lambda_function[count.index].arn
  function_version = "$LATEST"
  depends_on       = [aws_lambda_function.lambda_function]
}

resource "aws_lambda_event_source_mapping" "lambda_function_mapping" {
  count            = var.create_lambda && var.create_sqs ? var.sqs_count : 0
  event_source_arn = aws_sqs_queue.sqs_queue[count.index].arn
  function_name    = aws_lambda_function.lambda_function[count.index].arn
  batch_size       = var.batch_size
  depends_on       = [aws_lambda_function.lambda_function]
}
