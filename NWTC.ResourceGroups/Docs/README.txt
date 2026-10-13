NWTC.ResourceGroups
===================

MODULE PURPOSE
--------------
The purpose of this Module was to convert a standalone, enterprise-ready 
PowerShell function (New-TestResourceGroup) into a professional, reusable 
PowerShell module named NWTC.ResourceGroups.

FEATURES
--------
- Create a resource group by name or by project ID (using the RG- prefix).
- Accept one or more names directly or from the pipeline.
- Select an Azure location and provide tags. The default location is centralus.
- Support the standard -WhatIf and -Confirm options.
- Return each resource group's name, location, status, tags, and timestamp.
- Log operation start, results, errors, and summary to
  ResourceGroupLog-<timestamp>.txt in the current working directory.

INSTALLATION
------------
1. Ensure PowerShell 5.1 or PowerShell 7+ is available.
2. Install the Az.Resources dependency for Azure resource creation, if needed
3. Authenticate to Azure before creating resource groups:THIS IS A BIG ONE
4. Import the module manifest. From the repository root, run:

	Import-Module .\NWTC.ResourceGroups\NWTC.ResourceGroups.psd1

	Or, from the NWTC.ResourceGroups folder, run:

	Import-Module .\NWTC.ResourceGroups.psd1

USAGE EXAMPLES
--------------
Create a resource group using the default location and tags:

	New-TestResourceGroup -ResourceGroupName 'rg-app-test'

Create one from a project ID and choose a location:

	New-TestResourceGroup -ProjectID 'project-42' -Location 'eastus'

Create multiple resource groups by passing an array:

	New-TestResourceGroup -ResourceGroupName @('rg-web-test', 'rg-api-test')

Create multiple resource groups through the pipeline:

	@('rg-web-test', 'rg-worker-test') | New-TestResourceGroup -Location 'westus'

Preview a request without creating an Azure resource:

	New-TestResourceGroup -ResourceGroupName 'rg-preview' -WhatIf

Write-ModuleLog is a private helper used internally by the module and is not
exported for direct use. Log files are written relative to the current working
directory.

VERSION INFORMATION
--------------------
Module version: 1.0.0
Author: Tyler Krause
Description: Test resource groups creation
