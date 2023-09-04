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
  name = "api-cities"
  protocol_type = "HTTP"
}
