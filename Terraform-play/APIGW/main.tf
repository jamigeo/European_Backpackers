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

resource "aws_apigatewayv2_api" "API-cities" {

  name          = "api-cities"
  protocol_type = "HTTP"

  # integrations = {
  #   "POST /" = {
  #     lambda_arn             = "arn:aws:lambda:eu-central-1:093823058718:function:POST-cities"
  #     payload_format_version = "2.0"
  #     timeout_milliseconds   = 12000
  #   }

  #   "GET /" = {
  #     http_method            = "ANY"
  #     lambda_arn             = "arn:aws:lambda:eu-central-1:093823058718:function:GET-cities"
  #     payload_format_version = "2.0"
  #     timeout_milliseconds   = 12000

  #    }

  #  "$default" = {
  #    lambda_arn = "arn:aws:lambda:eu-central-1:093823058718:function:default-function"
  #  }
  # }
}

resource "aws_apigatewayv2_stage" "example" {
  # api_id = "aws_apigatewayv2_api.API-cities"
  # api_id = "API-cities"
  api_id = aws_apigatewayv2_api.API-cities.id
  name   = "$default"

  auto_deploy = true

}
