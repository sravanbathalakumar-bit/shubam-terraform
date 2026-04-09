resource aws_s3_bucket "bucket" {
  bucket = "my-unique-bucket-name-12345-bathala-kumar-puja"
  acl    = "private"

  tags = {
    Name        = "My S3 Bucket"
    Environment = "Dev"
  }
}