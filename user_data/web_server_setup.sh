#!/bin/bash
# Web server setup script

# Update system
apt update -y

# Install Apache web server
apt install -y apache2

# Start and enable Apache
systemctl start apache2
systemctl enable apache2

# Create a simple index page
echo "<h1>Web Server - $(hostname)</h1>" > /var/www/html/index.html
echo "<p>Instance ID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>" >> /var/www/html/index.html

# Setup user for bastion access
useradd -m webuser
echo "webuser:TechCorp2024!" | chpasswd
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd