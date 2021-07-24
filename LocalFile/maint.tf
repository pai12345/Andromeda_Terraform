module "generate_localfile"{
    source = "./modules/localfile"
    content     = var.content
    directory_permission = var.directory_permission
}