
resource "aws_sqs_queue" "sqs_queue" {
  count                             = var.create_sqs ? var.sqs_count : 0
  name                              = var.sqs_queue_name
  visibility_timeout_seconds        = "180" # 6 x 30s Lambda timeout
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 300
  redrive_policy                    = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.sqs_dlq[count.index].arn}\",\"maxReceiveCount\":5}"
  tags = {
    BusinessUnit    = var.BusinessUnit
    Environment     = var.env
    CostCenter      = var.CostCenter
    Product         = var.Product
    DataSensitivity = var.DataSensitivity
  }
}

resource "aws_sqs_queue" "sqs_dlq" {
  count                             = var.create_sqs ? var.sqs_count : 0
  name                              = var.sqs_dlq_name
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 300
  tags = {
    BusinessUnit    = var.BusinessUnit
    Environment     = var.env
    CostCenter      = var.CostCenter
    Product         = var.Product
    DataSensitivity = var.DataSensitivity
  }
}

resource "aws_sqs_queue_policy" "sqs_queue_policy" {
  count     = var.create_sqs ? var.sqs_count : 0
  queue_url = aws_sqs_queue.sqs_queue[count.index].id
  policy    = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [{
  "Sid":"Queue1_SendMessage",
  "Effect": "Allow",
  "Principal": {
     "AWS": [
        "${var.account_id}"
     ]
  },
  "Action": [
         "sqs:SendMessage",
         "sqs:ReceiveMessage",
         "sqs:DeleteMessage"
      ],
      "Resource":"${aws_sqs_queue.sqs_queue[count.index].arn}"
      }]
}
POLICY
}

resource "aws_sqs_queue_policy" "sqs_dlq_policy" {
  count     = var.create_sqs ? var.sqs_count : 0
  queue_url = aws_sqs_queue.sqs_dlq[count.index].id
  policy    = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [{
  "Sid":"Queue1_SendMessage",
  "Effect": "Allow",
    "Principal": {
     "AWS": [
        "${var.account_id}"
     ]
  },
  "Action": [
         "sqs:SendMessage",
         "sqs:ReceiveMessage",
         "sqs:DeleteMessage"
      ],
      "Resource":"${aws_sqs_queue.sqs_dlq[count.index].arn}"
      }]
}
POLICY
}
