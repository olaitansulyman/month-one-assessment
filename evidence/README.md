# Evidence - AWS Infrastructure Screenshots

This folder contains screenshots demonstrating the deployed AWS infrastructure.

## Required Screenshots:

### AWS Console Screenshots:
- [ ] VPC Dashboard showing created VPC
- [ ] EC2 Instances (all 4 instances running)
- [ ] Load Balancer configuration and status
- [ ] Target Group showing unhealthy instances
- [ ] Security Groups
- [ ] Subnets (public and private)
- [ ] NAT Gateways
- [ ] Internet Gateway
- [ ] Route Tables

### Terminal Screenshots:
- [ ] `terraform plan` output
- [ ] `terraform apply` completion
- [ ] `terraform output` showing all values
- [ ] SSH connection to bastion host
- [ ] Load balancer URL attempt (502 error)

### Infrastructure Status:
- ✅ VPC and networking: DEPLOYED
- ✅ EC2 instances: RUNNING
- ✅ Load balancer: DEPLOYED
- ✅ Security groups: CONFIGURED
- ✅ Bastion access: WORKING
- ✅ Web servers: HEALTHY (Apache running)
- ✅ Load balancer health checks: PASSING
- ✅ **INFRASTRUCTURE FULLY OPERATIONAL**

## File Naming Convention:
- `01-vpc-dashboard.png`
- `02-ec2-instances.png`
- `03-load-balancer.png`
- `04-security-groups.png`
- `05-subnets.png`
- `06-terraform-output.png`
- `07-bastion-ssh.png`
- `08-502-error.png`