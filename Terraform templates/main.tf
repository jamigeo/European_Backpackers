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

resource "aws_iam_role" "this" {

name = "advancedAWSidRole-2024"
  
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "${var.statement}",
      "Action": "${var.service}:${var.action}",
      "Effect": "${var.effect}",
      "Resource": "arn:aws:${var.service}:${var.region}:${var.account}:${var.resource_type}/${var.resource_path}"
    }
  ]
}
EOF
  tags = {
    "Name" = "advanced"
  }
}