terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region
}

resource "aws_lambda_function" "POST-city" {
  filename = "lambda-zip/post-city.zip"
  function_name = "POST-city"
  role = "arn:aws:iam::${var.aws_account_id}:role/service-role/0706-DB-Interaction"
  handler = "lambda_function.lambda_handler"
  runtime = "python3.10"
}