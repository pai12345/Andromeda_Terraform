variable "variable_iam_user" {
  type = list(object({
    name = string
    path = string
    force_destroy = bool
    password = number
    password_reset_required = string
    tags = map(string) 
  }))
  sensitive = false
}

variable "variable_iam_policy" {
  type = object({
    name = string
    description = string
    path = string
  })
  default = {
    name = "adminuser" 
    description = "IAM policy for root user"
    path = "/home/"
  }
  sensitive = false
}

variable "variable_iam_group" {
  type = object({
    name = string
    path = string
  })
  default = {
    name = "supergroup"
    path = "/home/"
  }
  sensitive = false
}