resource "aws_dynamodb_table" "retail_store" {
  name         = "${var.project_name}-retail-store"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "${var.project_name}-retail-store"
  }
}