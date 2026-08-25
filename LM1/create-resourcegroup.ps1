param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('centralus', 'eastus', 'westus', 'northcentralus', 'southcentralus')]
    [string]$Location,
    
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
)

# Start logging to a transcript file
$TranscriptPath = ".\ResourceGroupLog-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"
Start-Transcript -Path $TranscriptPath

try {
    Write-Host "Attempting to create Resource Group $ResourceGroupName in $Location ..." -ForegroundColor Cyan
    
    # Force errors to stop script execution so they trigger the catch block
    New-AzResourceGroup -Name $ResourceGroupName -Location $Location -ErrorAction Stop
    
    Write-Host "Success! Resource Group created successfully." -ForegroundColor Green
} catch {
    Write-Host "Error: Failed to create the resource group." -ForegroundColor Red
    # Outputs the exact error message from Azure
    Write-Host $_.Exception.Message -ForegroundColor Yellow
} finally {
    # Ensure transcript stops even if an error occurs
    Stop-Transcript
}