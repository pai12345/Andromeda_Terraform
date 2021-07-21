#===================Output Module generate_s3_createbucket=====================#
output output_generate_s3_createbucket {
    value=module.generate_s3_createbucket
    sensitive = false
    description = "Output for Module S3 CreateBucket"
}