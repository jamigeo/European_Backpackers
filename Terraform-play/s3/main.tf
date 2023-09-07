
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