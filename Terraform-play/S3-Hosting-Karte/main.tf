provider "aws" {
  region = "eu-central-1"  # Set your desired AWS region
}

resource "aws_s3_bucket" "example" {
  bucket = "example-website-bucket"  # Set your desired bucket name
  acl    = "public-read"  # Set the bucket ACL to make objects publicly readable

  website {
    index_document = "index.html"  # Set the main HTML file for your website
    error_document = "error.html"  # Set the error page for your website (optional)
  }
}

# Create a simple HTML file (index.html) and an error page (error.html)
resource "aws_s3_bucket_object" "index" {
  bucket       = aws_s3_bucket.example.id
  key          = "index.html"
  content_type = "text/html"
  source       = "./project-cities-map/src/index.html"  # Path to your local HTML file
}

resource "aws_s3_bucket_object" "error" {
  bucket       = aws_s3_bucket.example.id
  key          = "error.html"
  content_type = "text/html"
  source       = "./project-cities-map/src/index.html"  # Path to your local error HTML file (optional)
}
