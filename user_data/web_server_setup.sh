#!/bin/bash
set -euo pipefail

# EC2 user data runs as root.
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install -y apache2
systemctl enable --now apache2

cat > /var/www/html/index.html <<'HTML'
<!doctype html>
<html lang="en">
<head><meta charset="utf-8"><title>Terraform Web Tier</title></head>
<body>
  <h1>Web server provisioned by Terraform</h1>
  <p>Instance hostname: PLACEHOLDER</p>
</body>
</html>
HTML

sed -i "s/PLACEHOLDER/$(hostname)/" /var/www/html/index.html

# SSH access is key-based through the bastion security group.
# Do not create password-authenticated users or enable SSH password login here.
