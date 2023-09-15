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

data "aws_iam_policy_document" "trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_dynamodb_table" "european-cities" {
  name = "european-cities"
  billing_mode = "PROVISIONED"
  read_capacity= "30"
  write_capacity= "30"
  attribute {
    name = "name"
    type = "S"
  }
  hash_key = "name"
}

# DynamoDB Interaction : genric AWS Policy / Service Role
resource "aws_iam_role" "Lambda-EB-Interaction" {
  name               = "Lambda-EB-Interaction"
  assume_role_policy = data.aws_iam_policy_document.trust_policy.json
  managed_policy_arns = [
              "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
              "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
              "arn:aws:iam::aws:policy/AmazonS3FullAccess"
            ]
}

# Lambda 
resource "aws_lambda_function" "POST-city" {
  filename      = "lambda-zip/post_city.zip"
  function_name = "POST-city"
  role          = "arn:aws:iam::${var.aws_account_id}:role/Lambda-EB-Interaction"
  handler = "post_city.lambda_handler"
  runtime = "python3.10"
  timeout = "60"
}

resource "aws_lambda_function" "GET-cities" {
  filename      = "lambda-zip/get_cities.zip"
  function_name = "GET-cities"
  role          = "arn:aws:iam::${var.aws_account_id}:role/Lambda-EB-Interaction"
  handler = "get_cities.lambda_handler"
  runtime = "python3.10"
}

resource "aws_lambda_function" "import-cities" {
  filename      = "lambda-zip/import_cities.zip"
  function_name = "import-cities"
  role          = "arn:aws:iam::${var.aws_account_id}:role/Lambda-EB-Interaction"
  handler = "import_cities.lambda_handler"
  runtime = "python3.10"
  timeout = "60"

}

