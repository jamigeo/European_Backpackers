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