<#
.SYNOPSIS
    Creates test resource groups and records the operation in a log file.

.DESCRIPTION
    Creates Azure resource groups for the supplied resource group names or project IDs,
    and writes progress messages to a timestamped module log.

.PARAMETER ResourceGroupName
    One or more resource group names to create. Names can also be supplied through the pipeline.

.PARAMETER ProjectID
    The project ID used to construct a resource group name with the RG- prefix.

.PARAMETER Location
    The Azure location in which to create the resource group.

.PARAMETER Tags
    Tags to assign to the resource group.
#>
function New-TestResourceGroup {
    [CmdletBinding(SupportsShouldProcess=$true, DefaultParameterSetName='ResourceGroupName')]
    param (
        [Parameter(Mandatory=$true, ParameterSetName='ResourceGroupName', ValueFromPipeline=$true)]
        [string[]]$ResourceGroupName,

        [Parameter(Mandatory=$true, ParameterSetName='ProjectID')]
        [string]$ProjectID,

        [Parameter(Mandatory=$false)]
        [ValidateSet('centralus', 'eastus', 'westus', 'northcentralus', 'southcentralus')]
        [string]$Location = 'centralus',

        [Parameter(Mandatory=$false)]
        [hashtable]$Tags = @{
            Department  = "IT"
            Environment = "Test"
        }
    )

    begin {
        $totalRequestsProcessed = 0
        $resourcesCreated = 0
        $resourcesSkipped = 0
        $errorsEncountered = 0
        $logPath = ".\ResourceGroupLog-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"
        Write-ModuleLog -Path $logPath -Message 'New-TestResourceGroup function started.'

        Write-Verbose 'New-TestResourceGroup function started; initialized counters and logging.'
        Write-Host 'Starting resource group creation.' -ForegroundColor Cyan
    }

    process {
        $resourceGroupNames = if ($PSCmdlet.ParameterSetName -eq 'ProjectID') {
            @("RG-$ProjectID")
        } else {
            $ResourceGroupName
        }

        foreach ($resolvedResourceGroupName in $resourceGroupNames) {
            $totalRequestsProcessed++

            $result = [PSCustomObject]@{
                ResourceGroupName = $resolvedResourceGroupName
                Location          = $Location
                Status            = 'Not Created'
                Tags              = $Tags
                Timestamp         = Get-Date
            }

            Write-Verbose "Validation succeeded for resource group '$resolvedResourceGroupName' in '$Location'."

            try {
                Write-Host "Attempting to create resource group '$resolvedResourceGroupName' in $Location..." -ForegroundColor Cyan
                Write-Verbose "Attempting to create resource group '$resolvedResourceGroupName' in '$Location'."
                Write-ModuleLog -Path $logPath -Message "Attempting to create resource group '$resolvedResourceGroupName' in '$Location'."

                if ($PSCmdlet.ShouldProcess("Resource Group '$resolvedResourceGroupName'", 'Create')) {
                    New-AzResourceGroup -Name $resolvedResourceGroupName -Location $Location -Tag $Tags -ErrorAction Stop | Out-Null
                    $result.Status = 'Created'
                    $resourcesCreated++
                    Write-Host "Resource group '$resolvedResourceGroupName' created successfully." -ForegroundColor Green
                    Write-Verbose "Resource group '$resolvedResourceGroupName' completed successfully."
                    Write-ModuleLog -Path $logPath -Message "Resource group '$resolvedResourceGroupName' created successfully."
                } else {
                    $result.Status = 'Skipped'
                    $resourcesSkipped++
                    Write-ModuleLog -Path $logPath -Message "Resource group '$resolvedResourceGroupName' was skipped."
                }
            } catch {
                $result.Status = 'Failed'
                $errorsEncountered++
                Write-Host "Failed to create resource group '$resolvedResourceGroupName': $($_.Exception.Message)" -ForegroundColor Red
                Write-ModuleLog -Path $logPath -Message "Failed to create resource group '$resolvedResourceGroupName': $($_.Exception.Message)"
            }

            $result
        }
    }

    end {
        Write-Host ''
        Write-Host 'Resource Group Processing Summary' -ForegroundColor Cyan
        Write-Host ('-' * 36) -ForegroundColor DarkGray
        Write-Host ('  Total requests processed : {0}' -f $totalRequestsProcessed)
        Write-Host ('  Resources created        : {0}' -f $resourcesCreated)
        Write-Host ('  Resources skipped        : {0}' -f $resourcesSkipped)
        Write-Host ('  Errors encountered       : {0}' -f $errorsEncountered)
        Write-Verbose "Function completed: $totalRequestsProcessed requests processed; $resourcesCreated created, $resourcesSkipped skipped, $errorsEncountered errors."
        Write-ModuleLog -Path $logPath -Message "Function completed: $totalRequestsProcessed requests processed; $resourcesCreated created, $resourcesSkipped skipped, $errorsEncountered errors."
    }
}