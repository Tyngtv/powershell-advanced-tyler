# powershell-advanced-tyler

## `Write-ModuleLog`

`Write-ModuleLog` is a private helper in the `NWTC.ResourceGroups` module. It appends a message with a `yyyy-MM-dd HH:mm:ss` timestamp to the log file at the supplied path. If the file's parent directory does not exist, the function creates it. File-writing errors are reported as warnings.

### Parameters

- `Path` (required): Destination log file path. Can be relative or absolute.
- `Message` (required): Message text to append.

### Example

```powershell
Import-Module .\NWTC.ResourceGroups.psd1

# Write-ModuleLog is private and is called internally by New-TestResourceGroup.
# Example of the log entry format:
# 2026-10-13 14:30:00 - Processing started.
New-TestResourceGroup -ResourceGroupName 'rg-example' -WhatIf
```

`New-TestResourceGroup` accepts one or more resource group names either as an array or through the pipeline, and creates timestamped log files named `ResourceGroupLog-<timestamp>.txt` in the current working directory. The log records the operation's start, outcome, and summary. Since `Write-ModuleLog` is private, it is not directly available as an exported command after importing the module.