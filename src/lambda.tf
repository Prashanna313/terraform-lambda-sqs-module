
module "prashanna_test" {
  source             = ".//serverless"
  create_lambda      = true
  lambda_count       = 1
  lambda_name        = "${var.env}-terraform-modules-test"
  lambda_description = "This lambda function will ingest student education details into C4C"
  lambda_handler     = "functions.test.handler"
  s3_bucket_name     = var.s3_bucket_name
  s3_bucket_key      = aws_s3_bucket_object.global-student-education-history-event-publisher-bucket-v1.id
  lambda_role_name   = "${var.env}-global-history-c4c-message-ingestor-exe-role"
  lambda_policy_name = "${var.env}-global-history-c4c-message-ingestor-exe-policy"
  env                = var.env
  account_id         = var.account_id

  create_sqs = false
}