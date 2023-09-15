/*
provider "aws" {
  region = "eu-central-1"  # Set your desired AWS region
}
resource "aws_s3_bucket" "example" {

  bucket = "eurpean-backers-bucket"  # Set your desired bucket name
  //acl    = "public-read"  # Set the bucket ACL to make objects publicly readable

  website {
    index_document = "index.html"  # Set the main HTML file for your website
   
  }
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}



resource "aws_s3_bucket" "example" {
  bucket = "example-website-bucket"  # Set your desired bucket name
  //acl    = "public-read"  # Set the bucket ACL to make objects publicly readable

  website {
    index_document = "index.html"  # Set the main HTML file for your website
    error_document = "index.html"  # Set the error page for your website (optional)
  }
}
resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}

# S3 bucket ACL access

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.my-static-website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.example.id
  acl    = "public-read"
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
*/

variable "region" {
  default = "eu-central-1"
}

# aws provider block

provider "aws" {
  region = var.region
}

# S3 static website bucket

resource "aws_s3_bucket" "my-static-website" {
  bucket = "my-static-website46551" # give a unique bucket name
  tags = {
    Name = "my-static-website"
  }
  website {
    index_document = "index.html"  # Set the main HTML file for your website
    
  }
}
resource "aws_s3_bucket_object" "index" {
  bucket       = aws_s3_bucket.my-static-website.id
  key          = "index.html"
  content_type = "text/html"
  source       = "./project-cities-map/src/index.html"  # Path to your local HTML file
}
resource "aws_s3_bucket_website_configuration" "my-static-website" {
  bucket = aws_s3_bucket.my-static-website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_versioning" "my-static-website" {
  bucket = aws_s3_bucket.my-static-website.id
  versioning_configuration {
    status = "Enabled"
  }
}

# S3 bucket ACL access

resource "aws_s3_bucket_ownership_controls" "my-static-website" {
  bucket = aws_s3_bucket.my-static-website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "my-static-website" {
  bucket = aws_s3_bucket.my-static-website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "my-static-website" {
  depends_on = [
    aws_s3_bucket_ownership_controls.my-static-website,
    aws_s3_bucket_public_access_block.my-static-website,
  ]

  bucket = aws_s3_bucket.my-static-website.id
  acl    = "public-read"
}





# s3 static website url

output "website_url" {
  value = "http://${aws_s3_bucket.my-static-website.bucket}.s3-website.${var.region}.amazonaws.com"
}