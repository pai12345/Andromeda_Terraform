# terraform {
#   required_providers {
#     aws = {
#       source = "hashicorp/aws"
#       version = "3.49.0"
#     }
#   }
#   backend "s3" {
#     bucket = "andrterraformbackend"
#     encrypt = true
#     key    = "prod/terraform.tfstate"
#     dynamodb_table = "terraform_locks"
#     region = "us-east-1"
#   }
# }

terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.1.0"
    }
  }
}