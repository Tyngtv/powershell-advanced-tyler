$publicFunctions = Get-ChildItem -Path "$PSScriptRoot\Public\*.ps1" -ErrorAction SilentlyContinue

foreach ($functionFile in $publicFunctions) {
	. $functionFile.FullName
}
