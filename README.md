# Azure Infrastructure as Code with ARM Templates

Automated Azure infrastructure deployment using ARM (Azure Resource Manager) templates. This project demonstrates Infrastructure as Code principles by defining and deploying a complete web server environment through JSON templates instead of manual portal configuration.

## Live Demo

🌐 **Website URL:** `http://172.190.250.152`

## Project Overview

This project showcases the power of Infrastructure as Code by automating the deployment of a complete web server infrastructure on Azure. Instead of manually clicking through the Azure portal to create resources, everything is defined in version-controlled JSON templates that can be deployed with a single command.

## What This Project Demonstrates

### Infrastructure as Code Skills
- ARM template development in JSON
- Resource dependencies and orchestration
- Parameterized infrastructure for reusability
- Version control for infrastructure definitions
- Automated deployment workflows

### Azure Cloud Services
- Azure Resource Manager templates
- Virtual Machine provisioning
- Virtual Network configuration
- Network Security Groups
- Public IP addresses (Standard SKU)
- Resource group management

### Problem-Solving
- Troubleshooting quota limitations
- Switching from Basic to Standard SKU public IPs
- Understanding Azure resource dependencies
- Deployment validation and error handling

## Architecture

The ARM template creates the following infrastructure:

```
Azure Resource Group
├── Virtual Network (10.0.0.0/16)
│   └── Default Subnet (10.0.0.0/24)
├── Network Security Group
│   ├── SSH Rule (Port 22)
│   └── HTTP Rule (Port 80)
├── Public IP Address (Standard SKU, Static)
├── Network Interface
│   ├── Connected to Virtual Network
│   ├── Associated with NSG
│   └── Attached to Public IP
└── Virtual Machine (Ubuntu 22.04 LTS)
    ├── Standard_B1s size
    ├── Nginx web server
    └── Custom HTML webpage
```

## Project Files

- **`webserver-template.json`** - Main ARM template defining all infrastructure resources
- **`webserver-parameters.json`** - Parameter file for deployment configuration
- **`deploy.ps1`** - PowerShell script for automated deployment
- **`README.md`** - This documentation file

## ARM Template Features

### Parameters
- `vmName` - Virtual machine name (default: webServerVM)
- `adminUsername` - VM administrator username
- `adminPassword` - Secure password parameter
- `vmSize` - VM size selection (B1s, B2s, B1ms)
- `location` - Azure region for deployment

### Variables
- Automatically generated resource names based on VM name
- Consistent naming convention across resources
- Network configuration (address spaces, subnet ranges)

### Resources Defined
1. Virtual Network with subnet
2. Network Security Group with inbound rules
3. Public IP Address (Standard SKU)
4. Network Interface with dependencies
5. Virtual Machine with Ubuntu 22.04 LTS

### Outputs
- Public IP address for accessing the server
- Pre-formatted SSH connection string

## Deployment Process

### Method 1: Azure Portal
1. Navigate to "Deploy a custom template" in Azure portal
2. Load `webserver-template.json`
3. Fill in parameters
4. Click "Review + create" then "Create"

### Method 2: PowerShell (Azure Cloud Shell)
```powershell
# Create resource group
New-AzResourceGroup -Name "webserver-iac-rg" -Location "East US"

# Deploy template
New-AzResourceGroupDeployment `
    -ResourceGroupName "webserver-iac-rg" `
    -TemplateFile "webserver-template.json" `
    -TemplateParameterFile "webserver-parameters.json"
```

### Method 3: Azure CLI
```bash
# Create resource group
az group create --name webserver-iac-rg --location eastus

# Deploy template
az deployment group create \
    --resource-group webserver-iac-rg \
    --template-file webserver-template.json \
    --parameters @webserver-parameters.json
```

## Post-Deployment Configuration

After the infrastructure is deployed, Nginx web server setup:

```bash
# Connect via SSH
ssh [username]@[public-ip]

# Update package list
sudo apt update

# Install Nginx
sudo apt install nginx -y

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Create custom webpage
cd /var/www/html
sudo mv index.nginx-debian.html index.nginx-debian.html.backup
sudo nano index.html
# Paste custom HTML content
```

## Key Learnings

### Infrastructure as Code Benefits
- **Repeatability**: Deploy identical environments consistently
- **Version Control**: Track infrastructure changes over time
- **Documentation**: Templates serve as infrastructure documentation
- **Speed**: Deploy complex infrastructure in minutes, not hours
- **Reduced Errors**: Eliminate manual configuration mistakes

### Technical Insights
- Understanding Azure resource dependencies and deployment order
- Working with ARM template syntax and functions
- Troubleshooting deployment failures and quota limitations
- Difference between Basic and Standard SKU resources
- Secure parameter handling for sensitive data

### Cloud Engineering Best Practices
- Parameterizing templates for flexibility
- Using consistent naming conventions
- Implementing proper resource dependencies
- Planning for different environments (dev, test, prod)
- Documenting deployment procedures

## Comparison: Manual vs IaC

| Aspect | Manual Deployment (Project 1) | Infrastructure as Code (Project 2) |
|--------|------------------------------|-------------------------------------|
| **Time** | 30-45 minutes | 5-10 minutes |
| **Clicks** | 15+ screens | Single deployment |
| **Consistency** | Varies each time | Identical every time |
| **Documentation** | Manual notes | Self-documenting code |
| **Version Control** | Not possible | Full Git history |
| **Rollback** | Manual recreation | Redeploy previous version |
| **Team Collaboration** | Screenshots/docs | Shared templates |
| **Error Rate** | Higher (human error) | Lower (validated templates) |

## Troubleshooting Notes

### Public IP Quota Limitation
**Issue**: Basic SKU public IP quota limit of 0 in free subscription

**Solution**: Updated template to use Standard SKU public IP with static allocation
```json
"sku": {
    "name": "Standard"
},
"properties": {
    "publicIPAllocationMethod": "Static"
}
```

### Availability Zone Capacity
**Issue**: VM size not available in selected availability zone

**Solution**: Changed region from West US 2 to East US for better capacity

## Future Enhancements

- [ ] Add Azure Monitor and Log Analytics integration
- [ ] Implement automated backup configuration
- [ ] Create separate templates for dev/test/prod environments
- [ ] Add Azure Key Vault for secret management
- [ ] Implement custom script extension for automated Nginx setup
- [ ] Create Bicep version of ARM template (newer Azure IaC language)
- [ ] Add Azure DevOps pipeline for CI/CD deployment
- [ ] Implement load balancer for multi-VM deployment
- [ ] Add application gateway with WAF
- [ ] Create Terraform version for comparison

## Cost Management

### Resource Costs (Approximate)
- **Virtual Machine (B1s)**: ~$7.59/month
- **Standard Public IP**: ~$3.65/month
- **Storage (OS Disk)**: ~$5.00/month
- **Network egress**: Variable based on traffic

**Total estimated cost**: ~$16-20/month (covered by Azure free credits)

### Cost Optimization Tips
- Stop VMs when not in use
- Use auto-shutdown schedules
- Delete test environments after demos
- Monitor spending with Azure Cost Management

## Resources & References

- [ARM Template Documentation](https://docs.microsoft.com/azure/azure-resource-manager/templates/)
- [ARM Template Best Practices](https://docs.microsoft.com/azure/azure-resource-manager/templates/best-practices)
- [Azure Quickstart Templates](https://github.com/Azure/azure-quickstart-templates)
- [ARM Template Functions](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-functions)

## Connect

This is my second Azure cloud engineering project demonstrating progression from manual deployment to automated Infrastructure as Code. Both projects are part of my portfolio showcasing hands-on cloud skills.

**Related Projects:**
- [Project 1: Azure Web Server (Manual Deployment)](../azure-web-server-project)

---

**Project Status**: ✅ Deployed and running  
**Deployment Date**: October 1, 2025  
**Infrastructure**: Defined as code and version controlled  
**Cost**: Using Azure free tier credits
