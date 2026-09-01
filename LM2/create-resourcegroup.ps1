[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [ValidateSet('centralus', 'eastus', 'westus', 'northcentralus', 'southcentralus')]
    [string]$Location,

    [string]$TargetDirectory = "C:\Backup"
)

# Start logging
$TranscriptPath = ".\ResourceGroupLog-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"
Start-Transcript -Path $TranscriptPath

try {
    # Step 1: Initialization and Environment Check
    Write-Verbose "Starting Step 1: Initializing script and checking environment."
    $status = "Initializing..."
    Write-Output "Status: $status"

    if (-not (Test-Path -Path $TargetDirectory)) {
        Write-Debug "Target directory not found. Attempting creation: $TargetDirectory"
        Write-Verbose "Creating missing directory: $TargetDirectory"
        New-Item -ItemType Directory -Path $TargetDirectory | Out-Null
    } else {
        Write-Debug "Target directory already exists: $TargetDirectory"
    }

    # Step 2: Data Processing (Resource Group Creation)
    Write-Verbose "Starting Step 2: Processing data payload."
    $status = "Processing data..."
    Write-Output "Status: $status"

    Write-Host "Attempting to create Resource Group $ResourceGroupName in $Location ..." -ForegroundColor Cyan
    New-AzResourceGroup -Name $ResourceGroupName -Location $Location -ErrorAction Stop
    Write-Host "Success! Resource Group created successfully." -ForegroundColor Green

    $files = Get-ChildItem -Path $env:USERPROFILE\Documents -File
    Write-Debug "Total files discovered for processing: $($files.Count)"
    foreach ($file in $files) {
        Write-Verbose "Evaluating file: $($file.Name)"
    }

    # Step 3: Finalization and Cleanup
    Write-Verbose "Starting Step 3: Finalizing operations."
    $status = "Finalizing and cleaning up..."
    Write-Output "Status: $status"

    Write-Debug "Closing open file handles and releasing resources."
    Write-Verbose "Script execution completed successfully."

    $status = "Completed"
    Write-Output "Status: $status"

} catch {
    Write-Host "Error: Failed to create the resource group." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Yellow
} finally {
    Stop-Transcript
}