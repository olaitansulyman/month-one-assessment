# Terraform AWS Infrastructure Assessment

A learning project that provisions a small AWS network and compute environment with Terraform. It demonstrates VPC/subnet design, routing, security groups, a public Application Load Balancer, two private web instances, a private PostgreSQL host, and NAT-based outbound access.

> **Project scope:** This is a portfolio/lab implementation, not a claim of a live production environment. Review the Terraform and scripts before deploying. AWS NAT Gateways, EC2 instances, Elastic IPs, and load balancers can incur charges.

## Architecture

- VPC with public and private subnets across two Availability Zones
- Internet Gateway and public route table
- Two NAT Gateways and private route tables for outbound access
- Public Application Load Balancer with HTTP listener
- Two Apache web instances in private subnets, registered as ALB targets
- One PostgreSQL EC2 instance in a private subnet
- Bastion host in a public subnet with SSH ingress restricted by `my_ip`
- Security groups limiting database port 5432 to the web security group

**Note:** The current configuration uses two fixed web EC2 instances; it does not create an Auto Scaling Group. The ALB listener is HTTP only; HTTPS/TLS termination is not configured in this version.

## Prerequisites

- AWS account and AWS CLI
- Terraform >= 1.0
- An EC2 key pair in the selected AWS Region
- Your trusted public IP address in CIDR notation for bastion SSH access

## Configure

Copy the example variables file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Set `key_name` to an existing EC2 key pair and set `my_ip` to your current trusted public IP in CIDR notation. Do not use `0.0.0.0/0` for SSH access. Keep `terraform.tfvars` out of source control.

## Deploy

From the repository root:

```bash
terraform init
terraform fmt -check -recursive
terraform validate
terraform plan
```

Review the plan, resource count, network exposure, and estimated AWS cost before applying:

```bash
terraform apply
```

## Access and application/database setup

- SSH to the bastion using the EC2 key pair; the web and database security groups permit SSH only from the bastion security group.
- No custom password-authenticated Linux users are created by the user-data scripts.
- The PostgreSQL user-data script installs PostgreSQL and creates an empty `appdb` database. It deliberately does not embed database passwords or configure remote PostgreSQL authentication.
- Before connecting an application, configure PostgreSQL listening/authentication rules through a secure administrative session and create an application database role using a secret manager or an interactive password prompt. The database security group allows TCP 5432 only from the web security group.

Do not place passwords in Terraform files, EC2 user data, shell command history, source control, or screenshots.

## Outputs

Terraform outputs include the load balancer DNS name, VPC ID, web instance private IPs, database private IP, and bastion public IP. Treat infrastructure outputs as operational information and avoid publishing live endpoints or identifiers without reviewing them.

## Cleanup

After reviewing the destroy plan, remove the lab resources:

```bash
terraform plan -destroy
terraform destroy
```

Confirm that NAT Gateways, Elastic IPs, EC2 instances, and the load balancer have been removed to prevent ongoing charges.

## Security practices demonstrated

- Bastion SSH ingress scoped to a user-supplied trusted CIDR
- Private placement for web and database instances
- Database ingress limited to the web security group
- No hardcoded Linux or database passwords in user data
- Terraform state, local variable files, plan files, and macOS metadata excluded by `.gitignore`

Terraform state can contain sensitive values. Use a protected remote backend with encryption, versioning, and restricted access for shared use.
