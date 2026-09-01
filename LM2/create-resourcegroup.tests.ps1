Describe "Resource Group Creation" {
    
    Context "When creating a resource group" {
        
        It "Test should create a resource group with expected properties" {
            # Arrange
            $resourceGroupName = "test-rg-$(Get-Random)"
            $location = "East US"
            
            # Act
            $resourceGroup = New-AzResourceGroup -Name $resourceGroupName -Location $location
            
            # Assert
            $resourceGroup | Should -Not -BeNullOrEmpty
            $resourceGroup.ResourceGroupName | Should -Be $resourceGroupName
            $resourceGroup.Location | Should -Be "eastus"
            $resourceGroup.ProvisioningState | Should -Be "Succeeded"
            
            # Cleanup
            Remove-AzResourceGroup -Name $resourceGroupName -Force -Confirm:$false
        }
    }
}
