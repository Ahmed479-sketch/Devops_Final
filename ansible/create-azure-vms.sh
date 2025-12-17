#!/bin/bash
# Script to create Azure VMs for Ansible configuration

RESOURCE_GROUP="ansible-vms-rg"
LOCATION="southeastasia"
VM_SIZE="Standard_B2s"
IMAGE="Ubuntu2204"
ADMIN_USER="azureuser"

echo "=========================================="
echo "Creating Azure VMs for Ansible"
echo "=========================================="
echo ""

# Create Resource Group
echo "Step 1: Creating Resource Group..."
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create Virtual Network
echo ""
echo "Step 2: Creating Virtual Network..."
az network vnet create \
  --resource-group $RESOURCE_GROUP \
  --name ansible-vnet \
  --address-prefix 10.0.0.0/16 \
  --subnet-name default \
  --subnet-prefix 10.0.1.0/24

# Create Network Security Group
echo ""
echo "Step 3: Creating Network Security Group..."
az network nsg create \
  --resource-group $RESOURCE_GROUP \
  --name ansible-nsg

# Allow SSH
az network nsg rule create \
  --resource-group $RESOURCE_GROUP \
  --nsg-name ansible-nsg \
  --name AllowSSH \
  --priority 1000 \
  --source-address-prefixes '*' \
  --source-port-ranges '*' \
  --destination-address-prefixes '*' \
  --destination-port-ranges 22 \
  --access Allow \
  --protocol Tcp

# Allow HTTP
az network nsg rule create \
  --resource-group $RESOURCE_GROUP \
  --nsg-name ansible-nsg \
  --name AllowHTTP \
  --priority 1001 \
  --source-address-prefixes '*' \
  --source-port-ranges '*' \
  --destination-address-prefixes '*' \
  --destination-port-ranges 80 \
  --access Allow \
  --protocol Tcp

# Create VMs
echo ""
echo "Step 4: Creating Web Server 1..."
az vm create \
  --resource-group $RESOURCE_GROUP \
  --name web-server-1 \
  --image $IMAGE \
  --size $VM_SIZE \
  --admin-username $ADMIN_USER \
  --generate-ssh-keys \
  --vnet-name ansible-vnet \
  --subnet default \
  --nsg ansible-nsg \
  --public-ip-address web-server-1-ip

echo ""
echo "Step 5: Creating Web Server 2..."
az vm create \
  --resource-group $RESOURCE_GROUP \
  --name web-server-2 \
  --image $IMAGE \
  --size $VM_SIZE \
  --admin-username $ADMIN_USER \
  --generate-ssh-keys \
  --vnet-name ansible-vnet \
  --subnet default \
  --nsg ansible-nsg \
  --public-ip-address web-server-2-ip

echo ""
echo "Step 6: Creating App Server 1..."
az vm create \
  --resource-group $RESOURCE_GROUP \
  --name app-server-1 \
  --image $IMAGE \
  --size $VM_SIZE \
  --admin-username $ADMIN_USER \
  --generate-ssh-keys \
  --vnet-name ansible-vnet \
  --subnet default \
  --nsg ansible-nsg \
  --public-ip-address app-server-1-ip

echo ""
echo "Step 7: Creating App Server 2..."
az vm create \
  --resource-group $RESOURCE_GROUP \
  --name app-server-2 \
  --image $IMAGE \
  --size $VM_SIZE \
  --admin-username $ADMIN_USER \
  --generate-ssh-keys \
  --vnet-name ansible-vnet \
  --subnet default \
  --nsg ansible-nsg \
  --public-ip-address app-server-2-ip

echo ""
echo "=========================================="
echo "Getting VM IP Addresses..."
echo "=========================================="
echo ""

WEB1_IP=$(az vm show -d -g $RESOURCE_GROUP -n web-server-1 --query publicIps -o tsv)
WEB2_IP=$(az vm show -d -g $RESOURCE_GROUP -n web-server-2 --query publicIps -o tsv)
APP1_IP=$(az vm show -d -g $RESOURCE_GROUP -n app-server-1 --query publicIps -o tsv)
APP2_IP=$(az vm show -d -g $RESOURCE_GROUP -n app-server-2 --query publicIps -o tsv)

echo "Web Server 1 IP: $WEB1_IP"
echo "Web Server 2 IP: $WEB2_IP"
echo "App Server 1 IP: $APP1_IP"
echo "App Server 2 IP: $APP2_IP"

echo ""
echo "=========================================="
echo "✓ All VMs Created Successfully!"
echo "=========================================="
echo ""
echo "Update ansible/hosts.ini with these IPs:"
echo "  <WEB_SERVER_1_IP> = $WEB1_IP"
echo "  <WEB_SERVER_2_IP> = $WEB2_IP"
echo "  <APP_SERVER_1_IP> = $APP1_IP"
echo "  <APP_SERVER_2_IP> = $APP2_IP"
echo ""
