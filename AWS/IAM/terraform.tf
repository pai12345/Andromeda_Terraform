terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.34.0"
    }
  }
    backend "remote" {
    organization = "Andromeda_Terraform_Cloud"
    workspaces {
      name = "Andromeda_Terraform_Workspace"
    }
  }
}