#!/bin/bash
set -euo pipefail

# EC2 user data runs as root.
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql postgresql-contrib
systemctl enable --now postgresql

# Create an empty application database. Configure the application role and
# password separately through a secure administrative session/secret manager.
# Never bake database passwords into user data: EC2 user data is retrievable
# by principals with instance access and can also be represented in Terraform state.
sudo -u postgres psql --set ON_ERROR_STOP=1 -c "CREATE DATABASE appdb;"
