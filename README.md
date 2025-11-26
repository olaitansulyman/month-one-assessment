# Terraform AWS Infrastructure Assessment

This Terraform configuration creates a complete AWS infrastructure with web servers, database server, and load balancer.

## Architecture

- **VPC** with public and private subnets across 2 availability zones
- **Application Load Balancer** in public subnets
- **2 Web servers** in private subnets with auto-scaling capability
- **1 Database server** in private subnet
- **NAT Gateways** for outbound internet access from private subnets
- **Security Groups** with proper access controls

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 1.0 installed
- An existing EC2 key pair (optional)

## Usage

1. Copy the example variables file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your specific values:
   ```hcl
   aws_region = "us-east-1"
   environment = "dev"
   key_name = "your-key-pair-name"
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Plan the deployment:
   ```bash
   terraform plan
   ```

5. Apply the configuration:
   ```bash
   terraform apply
   ```

## Outputs

- `load_balancer_dns`: URL to access the web application
- `vpc_id`: ID of the created VPC
- `web_server_private_ips`: Private IPs of web servers
- `database_private_ip`: Private IP of database server

## Clean Up

To destroy the infrastructure:
```bash
terraform destroy
```

## Security Notes

- Web servers are in private subnets and only accessible through the load balancer
- Database server is in private subnet and only accessible from web servers
- All resources are tagged with environment for easy identification