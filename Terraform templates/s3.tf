resource "aws_s3_bucket" "json-upload-for-dynamodb-bucket" {
  bucket = "json-upload-for-dynamodb-bucket"
  acl = "private"
}

resource "aws_s3_bucket_object" "marshalledEuropean_cities" {
  bucket = aws_s3_bucket.json-upload-for-dynamodb-bucket.id
  key = "marshalledEuropean_cities.json"
  source = "marshalledEuropean_cities.json"
}