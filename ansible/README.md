# Ansible Configuration Management for Course Management System

## Overview
This Ansible configuration automates the setup of infrastructure for the Course Management System across multiple servers.

## Infrastructure
- **2 Web Servers**: Nginx + Docker
- **2 Application Servers**: Node.js + Docker + Python

## Prerequisites
- Azure CLI installed and authenticated
- Ansible installed on control machine
- SSH access to target servers

## Setup Instructions

### Step 1: Create Azure VMs

Run in Azure Cloud Shell:

```bash
# Make script executable
chmod +x ansible/create-azure-vms.sh

# Create VMs
./ansible/create-azure-vms.sh
```

This will create:
- Resource Group: `ansible-vms-rg`
- 4 VMs: web-server-1, web-server-2, app-server-1, app-server-2
- Virtual Network with NSG (SSH and HTTP allowed)

### Step 2: Update Inventory File

After VMs are created, update `ansible/hosts.ini` with the public IP addresses displayed by the script.

Replace:
- `<WEB_SERVER_1_IP>` with actual IP
- `<WEB_SERVER_2_IP>` with actual IP
- `<APP_SERVER_1_IP>` with actual IP
- `<APP_SERVER_2_IP>` with actual IP

### Step 3: Install Ansible (if not installed)

On your control machine or Azure Cloud Shell:

```bash
# Install Ansible
sudo apt update
sudo apt install ansible -y

# Verify installation
ansible --version
```

### Step 4: Test Connectivity

```bash
# Test connection to all servers
ansible all -i ansible/hosts.ini -m ping

# Expected output: SUCCESS for all servers
```

### Step 5: Run Ansible Playbook

```bash
# Run the playbook
ansible-playbook -i ansible/hosts.ini ansible/playbook.yml

# Run with verbose output
ansible-playbook -i ansible/hosts.ini ansible/playbook.yml -v
```

## What the Playbook Does

### Web Servers Configuration
1. Updates system packages
2. Installs and configures Nginx
3. Installs Docker and Docker Compose
4. Configures Nginx as reverse proxy
5. Enables and starts services

### Application Servers Configuration
1. Updates system packages
2. Installs Node.js 18.x
3. Installs Python3 and pip
4. Installs Docker and Docker Compose
5. Installs PM2 for process management
6. Creates application directory
7. Enables and starts services

## Verification

After running the playbook, verify installations:

```bash
# Check Docker on all servers
ansible all -i ansible/hosts.ini -m shell -a "docker --version" -b

# Check Nginx on web servers
ansible webservers -i ansible/hosts.ini -m shell -a "nginx -v" -b

# Check Node.js on app servers
ansible appservers -i ansible/hosts.ini -m shell -a "node --version" -b

# Check service status
ansible all -i ansible/hosts.ini -m shell -a "systemctl status docker" -b
```

## Inventory Structure

```ini
[webservers]
web-server-1    # Nginx + Docker
web-server-2    # Nginx + Docker

[appservers]
app-server-1    # Node.js + Docker + Python
app-server-2    # Node.js + Docker + Python
```

## Playbook Structure

```yaml
- Configure Web Servers
  - Install Nginx
  - Install Docker
  - Configure reverse proxy
  
- Configure Application Servers
  - Install Node.js
  - Install Python
  - Install Docker
  - Install PM2
  
- Verify Installation
  - Check versions
  - Verify services
```

## Cleanup

To delete all resources:

```bash
az group delete --name ansible-vms-rg --yes --no-wait
```

## Troubleshooting

### SSH Connection Issues
```bash
# Test SSH manually
ssh -i ~/.ssh/id_rsa azureuser@<VM_IP>

# Check SSH key permissions
chmod 600 ~/.ssh/id_rsa
```

### Ansible Connection Issues
```bash
# Test with verbose output
ansible all -i ansible/hosts.ini -m ping -vvv

# Check inventory
ansible-inventory -i ansible/hosts.ini --list
```

### Playbook Errors
```bash
# Run with verbose output
ansible-playbook -i ansible/hosts.ini ansible/playbook.yml -vvv

# Check syntax
ansible-playbook ansible/playbook.yml --syntax-check
```

## Files Included

- `hosts.ini` - Ansible inventory file
- `playbook.yml` - Main Ansible playbook
- `create-azure-vms.sh` - Script to create Azure VMs
- `README.md` - This documentation

## Submission Files

For assignment submission:
- ✅ `hosts.ini` - Inventory configuration
- ✅ `playbook.yml` - Ansible playbook
- ✅ Screenshots of:
  - VM creation
  - Ansible playbook execution
  - Service verification
