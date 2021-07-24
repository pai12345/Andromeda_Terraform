#===================Output Module generate_s3=====================#
output output_generate_localfile {
    value=module.generate_localfile
    sensitive = true
    description = "Output for Module generate_localfile"
}