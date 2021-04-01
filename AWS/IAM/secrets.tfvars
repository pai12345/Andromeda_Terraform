variable_iam_user = [{
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