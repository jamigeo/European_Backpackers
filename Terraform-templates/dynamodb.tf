// run: aws sts get-caller-identity

// and: terraform version // on your comandline to ensure your systems are ready...


resource "aws_dynamodb_table" "european_cities" {
 name = "european_cities"
 billing_mode = "PROVISIONED"
 read_capacity= "15"
 write_capacity= "15"
 attribute {
  name = "noticeId"
  type = "S"
 }
 hash_key = "noticeId"
}
