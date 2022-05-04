#!/bin/bash
sudo apt -y update
sudo apt -y install nginx
echo "<h2>WebServer with IP: $myip</h2><br>Build by Terraform using External Script!"  >  /var/www/html/index.html
echo "<br><font color="blue">Hello World!!" >> /var/www/html/index.html
sudo systemctl start nginx

