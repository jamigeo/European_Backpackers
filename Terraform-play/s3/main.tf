
resource "aws_s3_bucket" "upload-bucket" {
  bucket = "uploads-3to-dynamo-db"
}

resource "aws_s3_bucket_public_access_block" "upload-bucket" {
  bucket = aws_s3_bucket.upload-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

locals {
  file_to_upload = "cities-reduced.json"
}

resource "null_resource" "upload_file" {
  triggers = {
    file_checksum = filemd5(local.file_to_upload)
  }

  provisioner "local-exec" {
    command = "aws s3 cp ${local.file_to_upload} s3://${aws_s3_bucket.upload-bucket.bucket}/"
  }
}

# Erstellen Sie eine lokale Zip-Datei mit Ihrer Lambda-Funktion
resource "null_resource" "create_lambda_zip" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "powershell.exe -command Compress-Archive -Path lambda_function.py -DestinationPath lambda_compressed.zip -Force"
  }

#   provisioner "local-exec" {
#   command = <<-EOT
#     powershell.exe -command mkdir deployment_package ;
#     powershell.exe -command cd deployment_package ;
#     powershell.exe -command python3 -m venv venv ;
#     powershell.exe -command .\\venv\\Scripts\\Activate.ps1 ;
#     powershell.exe -command pip install index ;
#     powershell.exe -command .\\venv\\Scripts\\Deactivate.ps1 ;
#     powershell.exe -command Compress-Archive -Path . -DestinationPath deployment_package.zip -Force ;
#     powershell.exe -command Compress-Archive -Path .\\deployment_package -DestinationPath .\\lambda_compressed.zip -Force
#   EOT
# }

}

# Erstellen Sie die Lambda-Funktion und verweisen Sie auf die lokale Zip-Datei
resource "aws_lambda_function" "Convert_JSON" {
  function_name = "Convert_JSON"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"
  role          = aws_iam_role.lambda_execution_role.arn
  filename      = "lambda_compressed.zip" # Pfad zur Zip-Datei
  timeout       = 60
}

# IAM-Rolle für die Lambda-Funktion
resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "access_policy" {
  name        = "access_policy"
  description = "IAM policy for S3 bucket access to dynamo DB"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:Query",
          "dynamodb:UpdateItem",
          "dynamodb:Scan",
          "dynamodb:DeleteItem"
        ],
        Effect = "Allow",
        Resource = "arn:aws:dynamodb:eu-central-1:093823058718:table/european-cities" # Region un AccountID durch variablen noch zu ersetzen.
      },
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject"
        ],
        Effect = "Allow",
        Resource = [
          "arn:aws:s3:::uploads-3to-dynamo-db",
          "arn:aws:s3:::uploads-3to-dynamo-db/*"
        ]
      }
    ]
  })
}


# IAM-Rollenrichtlinienanhang, um die S3-Politik an die Rolle anzuhängen
resource "aws_iam_policy_attachment" "policy_attachment" {
  name       = "policy_attachment"
  policy_arn = aws_iam_policy.access_policy.arn
  roles      = [aws_iam_role.lambda_execution_role.name]
}
