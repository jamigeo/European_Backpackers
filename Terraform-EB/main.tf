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
  region = "eu-central-1"
}

resource "aws_lambda_function" "myLambda" {
  filename = "myLambda.zip"
  function_name = "0706-Users-Get"
  role = "arn:aws:iam::646621414411:role/service-role/0706-DB-Interaction"
  handler = "lambda_function.lambda_handler"
  runtime = "python3.10"
}