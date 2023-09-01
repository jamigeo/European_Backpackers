// run: aws sts get-caller-identity

// and: terraform version // on your comandline to ensure your systems are ready...


resource "aws_dynamodb_table" "European_Backpackers_dynamodb_table" {
 name = "European_Backpackers_dynamodb_table"
 billing_mode = "PROVISIONED"
 read_capacity= "15"
 write_capacity= "15"
 attribute {
  name = "noticeId"
  type = "S"
 }
 hash_key = "noticeId"
}
