$a = Read-Host "RG Name"
New-AzResourceGroup -Name $a -Location centralus

This code has missing parameter names, there is no separate for the Read-host and New-AzResourcegroup and RG Name has a space in the middle witch wont work with PowerShell since it treats it as two sperate arguments. 
The main reason missing parameter names can cause issues is that it brakes the automated pipelines witch can crash and cause slowdowns or complete stoppages. Command syntax issues can be an issue because it will trigger failed execution errors, tools like GitHub actions or other azure tools will crash immediately. And invalid variable referenced can cause issues by deploying 2 sperate resource groups instead of the intended one, this can cause confusion, slowdowns and possible errors with future code. 
