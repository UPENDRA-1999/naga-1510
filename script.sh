#!/bin/bash
sudo apt update -y
sudo apt full-upgrade -y
sudo apt install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2

echo “<html><body> <p> welcome </p></body></html>” > var/www/html/index.html
