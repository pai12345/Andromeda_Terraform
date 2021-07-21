module "generate_s3_createbucket"{
    source = "./modules/createbucket"
    bucket = var.bucket
    acl    = var.acl
    force_destroy = var.force_destroy
    versioning = var.versioning
    sse_algorithm  = var.sse_algorithm
    tags = var.tags
}