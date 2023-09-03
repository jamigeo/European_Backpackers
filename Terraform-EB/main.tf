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


resource "aws_iam_role" "DynamoDB-Interaction" {
  name               = "DynamoDB-Interaction"
  assume_role_policy = data.aws_iam_policy_document.trust_policy.json
  # managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaDynamoDBExecutionRole"]
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"]
}

resource "aws_lambda_function" "POST-city" {
  filename      = "lambda-zip/post_city.zip"
  function_name = "POST-city"
  role          = "arn:aws:iam::${var.aws_account_id}:role/DynamoDB-Interaction"
  # role          = "arn:aws:iam::${var.aws_account_id}:role/service-role/0706-DB-Interaction"
  # role    = "arn:aws:iam::aws:policy/service-role/AWSLambdaDynamoDBExecutionRole"   # cannot assign generic role
  # handler = "lambda_function.lambda_handler"
  handler = "post_city.lambda_handler"
  runtime = "python3.10"
}


#####################################################################
resource "aws_lambda_function" "GET-cities" {
  filename      = "lambda-zip/get_cities.zip"
  function_name = "GET-cities"
  role          = "arn:aws:iam::${var.aws_account_id}:role/DynamoDB-Interaction"
  # handler = "lambda_function.lambda_handler"
  handler = "get_cities.lambda_handler"
  runtime = "python3.10"
}
#####################################################################


# resource "aws_iam_policy" "DB-Interaction" {
#   name = "DB-Interaction"
#   path = "/"
#   description = "DynamoDB Interaction Policy"

#   policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "dynamodb:DeleteItem",
#                 "dynamodb:GetItem",
#                 "dynamodb:PutItem",
#                 "dynamodb:Scan",
#                 "dynamodb:UpdateItem"
#             ],
#             "Resource": "arn:aws:dynamodb:eu-central-1:${var.aws_account}:table/*"
#         }
#     ]
# })
# }
