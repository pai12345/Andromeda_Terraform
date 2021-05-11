#!/bin/bash

# Function containing details for configuring nginx
function configure_nginx() {
    # Downloads the package lists from the repositories and Update them to get information on the newest versions of packages and their dependencies.
    sudo apt-get -y update

    # Install nginx
    sudo apt-get -y install nginx

    # Enable Nginx service
    systemctl enable nginx

    # Start Nginx service
    sudo service nginx start

    # Configure Hello World HTML Page
    cat >/var/www/html/index.nginx-debian.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    Hello World
</body>
</html>
EOF
}

# Execute function
configure_nginx
