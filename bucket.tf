resource "aws_kms_key" "example" {
  description             = "This key is used to encrypt bucket objects"
}

resource "aws_s3_bucket" "example" {
  bucket = "example"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.example.arn
      sse_algorithm     = "aws:kms"
    }
    bucket_key_enabled  = true
  }
}

resource "aws_s3_bucket_public_access_block" "public-access" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
