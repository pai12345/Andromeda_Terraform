  bucket = "andrbucketgrunt"
  acl    = "private"
  force_destroy = "true"
  versioning = true
  sse_algorithm  = "AES256"
  tags = {
    Type        = "S3 Bucket"
    Environment = "Andromeda"
  }