#!/bin/bash
# Web server setup script

# Update system
sudo apt update -y

# Install Apache web server
sudo apt install -y apache2

# Start and enable Apache
sudo systemctl start apache2
sudo systemctl enable apache2

# Create a simple index page
echo "<h1>Web Server - $(hostname)</h1>" | sudo tee /var/www/html/index.html
echo "<p>Instance ID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>" | sudo tee -a /var/www/html/index.html

# Setup user for bastion access
sudo useradd -m webuser
echo "webuser:TechCorp2024!" | sudo chpasswd
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd