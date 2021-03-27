variable "variable_iam_user" {
  type = list(object({
    name = string
    path = string
    force_destroy = bool
    password = number
    password_reset_required = string
    tags = map(string) 
  }))
  default = [{
    name = "pai1"
    path = "/home/"
    force_destroy = true
    password = 20
    password_reset_required = "true"
    tags = {
        superuser = "user having root access/admin rights"
    }
  },
  {
    name = "pai2"
    path = "/home/"
    force_destroy = true
    password = 20
    password_reset_required = "true"
    tags = {
        superuser = "user having root access/admin rights"
    }
  }]
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
}