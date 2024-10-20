# Variables
$resourceGroupName = "DemoGroup"
$location = "CanadaCentral"
$storageAccountName = "azureuser17"  # Must be unique across Azure

# Create a resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Create a storage account
New-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -SkuName "Standard_LRS" -Location $location

# Retrieve and display storage account properties
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName
$storageAccount | Format-List
