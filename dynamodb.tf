/*resource "aws_dynamodb_table" "tf_state_lock" {
  name = "TF-State-Lock"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
  attribute {
    type = "S"
    name = "LockID"
  }
}*/