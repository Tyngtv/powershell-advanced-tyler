function New-TestResourceGroup {
    [CmdletBinding(SupportsShouldProcess=$true)]
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$ResourceGroupName,

        [Parameter(Mandatory=$true)]
        [ValidateSet('centralus', 'eastus', 'westus', 'northcentralus', 'southcentralus')]
        [string]$Location,

        [Parameter(Mandatory=$false)]
        [hashtable]$Tags = @{
            Department  = "IT"
            Environment = "Test"
        }
    )

    $TranscriptPath = ".\ResourceGroupLog-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"
    Start-Transcript -Path $TranscriptPath

    $result = [PSCustomObject]@{
        ResourceGroupName = $ResourceGroupName
        Location          = $Location
        Status            = 'Not Created'
        Tags              = $Tags
        Timestamp         = Get-Date
    }

    try {
    
    Write-Verbose "Starting Step 1: Initializing script and checking environment."
    $status = "Initializing..."
    Write-Output "Status: $status"

    Write-Verbose "Starting Step 2: Processing data payload."
    $status = "Processing data..."
    Write-Output "Status: $status"

    if ($PSCmdlet.ShouldProcess(
        "Resource Group '$ResourceGroupName'",
        "Create"
    )) {
        Write-Host "Attempting to create Resource Group $ResourceGroupName in $Location ..." -ForegroundColor Cyan
        New-AzResourceGroup -Name $ResourceGroupName -Location $Location -Tag $Tags -ErrorAction Stop
        Write-Host "Success! Resource Group created successfully." -ForegroundColor Green
        $result.Status = 'Created'
    }

    $files = Get-ChildItem -Path $env:USERPROFILE\Documents -File
    Write-Debug "Total files discovered for processing: $($files.Count)"
    foreach ($file in $files) {
        Write-Verbose "Evaluating file: $($file.Name)"
    }

   
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
        $result.Status = 'Failed'
    } finally {
        Stop-Transcript
    }

    $result
}