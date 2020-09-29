###########
# Lambda Function
###########

variable "create_lambda" {
  type        = bool
  description = "(Required) Flag to indicate the creation of Lambda"
  default     = true
}

variable "lambda_count" {
  type        = number
  description = "(Required) Number of lambda to be created"
  default     = 1
}

variable "lambda_name" {
  type        = string
  description = "(Required) Name of the lambda function"
  default     = ""
}

variable "lambda_description" {
  type        = string
  description = "Description of your Lambda Function"
  default     = "description"
}

variable "s3_bucket_name" {
  type        = string
  description = "(Required) The S3 bucket name which contains source code"
  default     = ""
}

variable "s3_bucket_key" {
  type        = string
  description = "(Required) The S3 bucket key which contains source code"
  default     = ""
}

variable "memory_size" {
  type        = number
  description = "(optional) Lambda memory size. Valid value between 128 MB to 3008 MB, in 64 MB increments."
  default     = 512
}

variable "timeout" {
  type        = number
  description = "(optional) Lambda timeout in seconds"
  default     = 180
}

variable "runtime" {
  type        = string
  description = "(Required) The Lambda runtime"
  default     = "python3.7"
}

variable "lambda_handler" {
  type        = string
  description = "The lambda handler details"
}

variable "lambda_layers" {
  type        = list(string)
  description = ""
  default     = null
}

variable "vpc_subnet_ids" {
  description = "List of subnet ids when Lambda Function should run in the VPC. Usually private or intra subnets."
  type        = list(string)
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of security group ids when Lambda Function should run in the VPC."
  type        = list(string)
  default     = null
}

variable "batch_size" {
  type        = number
  description = "The batch size of SQS queue"
  default     = 10
}

###########
# SQS
###########

variable "create_sqs" {
  type        = bool
  description = "(Required) Flag to indicate SQS & Dlq creation"
  default     = true
}

variable "sqs_count" {
  type        = number
  description = "(Required) Number of SQS & dlq need to be created"
  default     = 1
}

variable "sqs_queue_name" {
  type        = string
  description = "(Required) The SQS queue name"
  default     = null
}

variable "sqs_dlq_name" {
  type        = string
  description = "(Required) SQS DLQ name"
  default     = null
}

###########
# IAM Roles and Policies
###########

variable "lambda_role_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "idp-lambda-role"
}

variable "lambda_policy_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "idp-lambda-policy"
}

###########
# Tags and Env variables
###########

variable "CostCenter" {
  default = "StudentPlacement"
}

variable "BusinessUnit" {
  default = "AWSDevelopment"
}

variable "Product" {
  default = "AWSIntegration"
}

variable "DataSensitivity" {
  default = "Yes"
}

variable "env" {
  default = "dev"
}

variable "account_id" {
  type        = string
  description = "(optional) describe your variable"
}