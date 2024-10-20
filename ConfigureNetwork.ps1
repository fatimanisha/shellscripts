# Variables
$resourceGroupName = "DemoGroup"
$location = "CanadaCentral"
$vnetName = "MyVNet"
$subnetName = "MySubnet"
$addressPrefix = "10.0.0.0/16"
$subnetPrefix = "10.0.0.0/24"

# Check if the resource group already exists
if (-not (Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name $resourceGroupName -Location $location
} else {
    Write-Host "Resource group '$resourceGroupName' already exists."
}

# Check if the virtual network already exists
$vnetExists = Get-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Name $vnetName -ErrorAction SilentlyContinue

if ($vnetExists) {
    Write-Host "Virtual network '$vnetName' already exists. Updating the existing network."
    # If it exists, we'll just get its current configuration
    $vnetConfig = $vnetExists
} else {
    # Create the virtual network
    Write-Host "Creating virtual network '$vnetName'."
    $vnetConfig = New-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Location $location -Name $vnetName -AddressPrefix $addressPrefix
}

# Check if the subnet already exists
$existingSubnet = $vnetConfig.Subnets | Where-Object { $_.Name -eq $subnetName }

if (-not $existingSubnet) {
    # Create the subnet only if it doesn't exist
    Write-Host "Creating subnet '$subnetName'."
    Add-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix $subnetPrefix -VirtualNetwork $vnetConfig
} else {
    Write-Host "Subnet '$subnetName' already exists in the virtual network."
}

# Update the virtual network to include the new subnet (if created)
$vnetConfig | Set-AzVirtualNetwork

# Display the virtual network and subnet information
$vnetConfig | Format-List
