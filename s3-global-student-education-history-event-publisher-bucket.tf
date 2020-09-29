# uploads Lambda zip file as object to S3 s3_bucket

resource "aws_s3_bucket_object" "global-student-education-history-event-publisher-bucket-v1" {
  bucket                 = var.s3_bucket_name
  key                    = "prashanna_modules_test/${module.modules_test.package_name}"
  source                 = module.modules_test.package_name
  depends_on             = [module.modules_test]
  server_side_encryption = "AES256"
  tags = {
    BusinessUnit    = var.BusinessUnit
    Environment     = var.env
    CostCenter      = var.CostCenter
    Product         = var.Product
    DataSensitivity = var.DataSensitivity
  }

}
