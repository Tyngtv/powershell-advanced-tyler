$privateFunctions = Get-ChildItem -Path "$PSScriptRoot\Private\*.ps1" -ErrorAction SilentlyContinue

foreach ($functionFile in $privateFunctions) {
	. $functionFile.FullName
}

$publicFunctions = Get-ChildItem -Path "$PSScriptRoot\Public\*.ps1" -ErrorAction SilentlyContinue

foreach ($functionFile in $publicFunctions) {
	. $functionFile.FullName
}

Export-ModuleMember -Function $publicFunctions.BaseName
