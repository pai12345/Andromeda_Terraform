# resource "local_file" "localfiletf" {
#     content     = "Hello World"
#     filename = "${path.module}/test.txt"
#     directory_permission = "0777"
# }

resource "local_file" "localfiletf" {
    content     = var.content
    filename = "${path.module}/test.txt"
    directory_permission = var.directorypermission
}