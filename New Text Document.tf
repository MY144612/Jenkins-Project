provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-terraform-s3-bucket-12345"  # Change to a unique name
  acl    = "private"

  tags = {
    Name        = "MyTerraformBucket1446121999"
    Environment = "Dev"
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.id
}
