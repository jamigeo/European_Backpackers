
resource "aws_s3_bucket" "upload-bucket" {
  bucket = var.aws_bucket_name
}

resource "aws_s3_bucket_public_access_block" "upload-bucket" {
  bucket = aws_s3_bucket.upload-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

locals {
  file_to_upload = "european-cities-list.json"
}

# Erstelle eine "null_resource", um das Hochladen der Datei zu steuern
resource "null_resource" "upload_file" {
  triggers = {
    file_checksum = filemd5(local.file_to_upload) # Verwende eine geeignete Funktion zum Berechnen des Datei-Checksums
  }

  # Verwende den "local-exec" Provisioner, um das AWS CLI zum Hochladen der Datei zu verwenden
  provisioner "local-exec" {
    command = "aws s3 cp ${local.file_to_upload} s3://${aws_s3_bucket.upload-bucket.bucket}/"
  }
}