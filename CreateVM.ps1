# Variables
$resourceGroupName = "DemoGroup"
$location = "CanadaCentral"
$vmName = "MyVM"
$image = "MicrosoftWindowsServer:WindowsServer:2022-Datacenter:latest"
$adminUsername = "azureuser"
$adminPassword = "Testing124!"

# Create a secure password object
$securePassword = ConvertTo-SecureString $adminPassword -AsPlainText -Force

# Create a credential object
$credential = New-Object System.Management.Automation.PSCredential($adminUsername, $securePassword)

# Create a resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Create a virtual machine
New-AzVM -ResourceGroupName $resourceGroupName -Name $vmName -Location $location -Image $image -Size "Standard_DS1_v2" -Credential $credential

