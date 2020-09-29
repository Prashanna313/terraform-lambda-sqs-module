
module "prashanna_sqs_test1" {
  source             = ".//serverless"
  create_lambda      = true
  lambda_count       = 1
  lambda_name        = "${var.env}-terraform-modules-test1"
  lambda_description = "This lambda function will ingest student education details into C4C"
  lambda_handler     = "functions.test.handler"
  s3_bucket_name     = var.s3_bucket_name
  s3_bucket_key      = aws_s3_bucket_object.global-student-education-history-event-publisher-bucket-v1.id
  lambda_role_name   = "${var.env}-global-history-c4c-message-ingestor-exe-role1"
  lambda_policy_name = "${var.env}-global-history-c4c-message-ingestor-exe-policy1"
  env                = var.env
  account_id         = var.account_id

  create_sqs     = true
  sqs_count      = 1
  sqs_queue_name = "${var.env}-terraform-modules-test1-queue"
  sqs_dlq_name   = "${var.env}-terraform-modules-test1-dlq"
}