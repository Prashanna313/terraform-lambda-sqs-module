variable "access_key" {
  description = "access key"
  default     = ""

}

variable "secret_key" {
  description = "secret key"
  default     = ""
}

variable "region" {
  default = "eu-central-1"
}

variable "env" {
  default = "dev"
}

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
variable "applicationname" {
  type        = string
  description = "(optional) describe your variable"
  default     = "aws-global-student-education-history-publication"
}
variable "account_id" {
  description = "account id"
  default     = "123456789"
}

variable "s3_bucket_name" {
  description = "s3 bucket name"
  default     = "terraform-prashanna"
}

locals {
  timestamp = timestamp()
  time      = formatdate("DD MMM YYYY hh:mm:ss ZZZ", timestamp())
}

variable "TF_RECREATE_MISSING_LAMBDA_PACKAGE" {
  default = "false"
}