# Tests/Script.Tests.ps1

Describe 'PowerShell Script Tests' {

    # Mock the Azure commands so no real Azure calls are made
    Mock New-AzResourceGroup { "Mocked Resource Group" }
    Mock New-AzVM { "Mocked Virtual Machine" }

    It 'Should create a resource group' {
        . ./YourScript.ps1  # Import the PowerShell script
        Assert-MockCalled -CommandName New-AzResourceGroup -Exactly -Times 1
    }

    It 'Should create a virtual machine' {
        . ./YourScript.ps1  # Import the PowerShell script
        Assert-MockCalled -CommandName New-AzVM -Exactly -Times 1
    }
}
