resource "aws_s3_bucket" "json-upload-for-dynamodb-bucket" {
  bucket = "json-upload-for-dynamodb-bucket"
  acl = "public-read"

  tags = {

    Name        = "json-upload-for-dynamodb-bucket"
    Environment = "Terraform templates"

  }
}

resource "aws_s3_bucket_object" "json-upload-for-dynamodb" {

  bucket = aws_s3_bucket.json-upload-for-dynamodb-bucket.id

  key    = "european_backpackers"
  acl    = "public-read"
  source = "european_cities.json"

  etag = filemd5("myfiles/yourfile.txt")

}

resource "aws_s3_bucket_object" "marshalledEuropean_cities" {
  bucket = aws_s3_bucket.json-upload-for-dynamodb-bucket.id
  key = "marshalledEuropean_cities.json"
  source = "marshalledEuropean_cities.json"
}