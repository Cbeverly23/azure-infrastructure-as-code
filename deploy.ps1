# Azure ARM Template Deployment Script
# Run this from Azure Cloud Shell or local PowerShell with Azure modules

param(
    [string]$ResourceGroupName = "webserver-rg",
    [string]$Location = "West US 2"
)

# Create resource group if it doesn't exist
$rg = Get-AzResourceGroup -Name $ResourceGroupName -ErrorAction SilentlyContinue
if (-not $rg) {
    Write-Host "Creating resource group: $ResourceGroupName"
    New-AzResourceGroup -Name $ResourceGroupName -Location $Location
}

# Deploy the template
Write-Host "Deploying web server infrastructure..."
New-AzResourceGroupDeployment `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile "webserver-template.json" `
    -TemplateParameterFile "webserver-parameters.json" `
    -Verbose

Write-Host "Deployment complete!"
