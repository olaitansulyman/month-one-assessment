#!/bin/bash
# Database server setup script

# Update system
apt update -y

# Install PostgreSQL
apt install -y postgresql postgresql-contrib

# Start and enable PostgreSQL
systemctl start postgresql
systemctl enable postgresql

# Configure PostgreSQL
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'TechCorp2024!';"
sudo -u postgres createdb appdb
sudo -u postgres psql -c "CREATE USER appuser WITH PASSWORD 'AppPassword123!';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE appdb TO appuser;"

# Setup user for bastion access
useradd -m dbuser
echo "dbuser:TechCorp2024!" | chpasswd
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd