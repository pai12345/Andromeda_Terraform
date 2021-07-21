resource "local_file" "localfiletf" {
    content     = var.content
    filename = "${path.module}/test.txt"
    directory_permission = var.directorypermission
}