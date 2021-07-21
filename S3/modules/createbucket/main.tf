resource "aws_s3_bucket" "andrbucketgrunt" {
  bucket = var.bucket
  acl    = var.acl
  force_destroy = var.force_destroy
  versioning {
    enabled = var.versioning
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = var.sse_algorithm
      }
    }
  }
  tags = var.tags
}