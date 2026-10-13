
function Get-ResourceGroupSummary {
	[CmdletBinding()]
	param (
		[Parameter(ValueFromPipeline = $true)]
		[ValidateNotNullOrEmpty()]
		[string[]]$ResourceGroupName
	)

	begin {
		$receivedResourceGroupName = $false
	}

	process {
		if ($PSBoundParameters.ContainsKey('ResourceGroupName')) {
			$receivedResourceGroupName = $true

			foreach ($name in $ResourceGroupName) {
				Get-AzResourceGroup -Name $name -ErrorAction Stop | ForEach-Object {
					$resolvedName = $_.ResourceGroupName
					if (-not $resolvedName) {
						$resolvedName = $_.Name
					}

					[PSCustomObject]@{
						ResourceGroupName = $resolvedName
						Location          = $_.Location
						Tags              = $_.Tags
					}
				}
			}
		}
	}

	end {
		if (-not $receivedResourceGroupName) {
			Get-AzResourceGroup -ErrorAction Stop | ForEach-Object {
				$resolvedName = $_.ResourceGroupName
				if (-not $resolvedName) {
					$resolvedName = $_.Name
				}

				[PSCustomObject]@{
					ResourceGroupName = $resolvedName
					Location          = $_.Location
					Tags              = $_.Tags
				}
			}
		}
	}
}
