/**
* Creates IAM policy for Lambda to send message to SQS and attaches it to a role
*/
resource "aws_iam_role" "lambda-exe-role" {
  count = var.create_lambda ? var.lambda_count : 0
  name  = var.lambda_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags = {
    BusinessUnit    = var.BusinessUnit
    Environment     = var.env
    CostCenter      = var.CostCenter
    Product         = var.Product
    DataSensitivity = var.DataSensitivity
  }


}

resource "aws_iam_policy" "lambda-exe-policy" {
  count       = var.create_lambda ? var.lambda_count : 0
  name        = var.lambda_policy_name
  description = "lambda-exe-policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
    "Action": [
              "sqs:DeleteMessage",
              "cloudwatch:PutMetricData",
              "sqs:ReceiveMessage",
              "ssm:GetParameter",
              "xray:PutTraceSegments",
              "s3:GetObjectAcl",
              "logs:CreateLogStream",
              "sns:Publish",
              "kms:Decrypt",
              "kms:Encrypt",
              "kms:DescribeKey",
              "kms:ListKeys",
              "kms:GenerateDataKey",
              "s3:GetBucketWebsite",
              "ec2:ModifyNetworkInterfaceAttribute",
              "s3:ListJobs",
              "sqs:SendMessage",
              "sqs:GetQueueAttributes",
              "logs:CreateLogGroup",
              "s3:GetObject",
              "s3:DescribeJob",
              "ec2:DescribeSubnets",
              "xray:PutTelemetryRecords",
              "logs:DescribeLogStreams",
              "s3:ListBucket",
              "s3:GetEncryptionConfiguration",
              "sqs:ListQueues",
              "s3:ListBucketMultipartUploads",
              "s3:GetBucketAcl",
              "logs:PutLogEvents",
              "s3:ListAllMyBuckets",
              "ec2:*",
              "lambda:GetEventSourceMapping",
              "lambda:ListEventSourceMappings",
              "lambda:UpdateEventSourceMapping",
              "lambda:InvokeAsync",
              "lambda:InvokeFunction",
              "events:DisableRule",
              "events:EnableRule",
              "rds:DescribeDBClusters"
                ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "lambda-exe-policy_attach" {
  count      = var.create_lambda ? var.lambda_count : 0
  role       = aws_iam_role.lambda-exe-role[count.index].name
  policy_arn = aws_iam_policy.lambda-exe-policy[count.index].arn
}

output "lambda-exe-role-name" {
  value = element(concat(aws_iam_role.lambda-exe-role.*.name, [""]), 0)
}