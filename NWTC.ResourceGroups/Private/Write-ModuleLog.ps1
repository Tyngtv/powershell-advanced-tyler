function Write-ModuleLog {
    <#
    .SYNOPSIS
        Writes a timestamped message to a module log file.

    .DESCRIPTION
        Creates the log file and its parent directory when necessary, then appends
        the supplied message.

    .PARAMETER Path
        The path of the log file to write to.

    .PARAMETER Message
        The message to append to the log file.

    .EXAMPLE
        Write-ModuleLog -Path '.\ResourceGroupLog.txt' -Message 'Processing started.'
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Message
    )

    try {
        $parentPath = Split-Path -Path $Path -Parent
        if ($parentPath -and -not (Test-Path -LiteralPath $parentPath)) {
            New-Item -ItemType Directory -Path $parentPath -Force -ErrorAction Stop | Out-Null
        }

        $logEntry = '{0} - {1}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $Message
        Add-Content -LiteralPath $Path -Value $logEntry -ErrorAction Stop
    }
    catch {
        Write-Warning "Could not write to module log '$Path': $($_.Exception.Message)"
    }
}