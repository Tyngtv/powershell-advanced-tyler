Original Code: Get-Process -Name explore
Error Message Received: Get-Process : Cannot find a process with the name "explore". Verify the process name and call the cmdlet again.
At line:1 char:1
Cause of error: There is no running program named explore on the system. 
Fix: Get-Process -Name explorer

**Example Of verbios**:Transcript started, output file is .\ResourceGroupLog-20260901-074122.txt
VERBOSE: Starting Step 1: Initializing script and checking environment.
Status: Initializing...
VERBOSE: Creating missing directory: C:\Backup
VERBOSE: Starting Step 2: Processing data payload.
Status: Processing data...
Attempting to create Resource Group rg-powershell-test in eastus ...

ResourceGroupName : rg-powershell-test
Location          : eastus
ProvisioningState : Succeeded
ResourceId        : /subscriptions/xxxx-xxxx/resourceGroups/rg-powershell-test

Success! Resource Group created successfully.
VERBOSE: Evaluating file: Document1.docx
VERBOSE: Evaluating file: Notes.txt
VERBOSE: Starting Step 3: Finalizing operations.
Status: Finalizing and cleaning up...
VERBOSE: Script execution completed successfully.
Status: Completed
Transcript stopped, output file is C:\powershell-advanced-tyler\LM1\ResourceGroupLog-20260901-074122.txt

**Example Of Debug Output**: Transcript started, output file is .\ResourceGroupLog-20260901-074510.txt
VERBOSE: Starting Step 1: Initializing script and checking environment.
Status: Initializing...

DEBUG: Target directory not found. Attempting creation: C:\Backup

Confirm
Continue with this operation?
[Y] Yes  [A] Yes to All  [H] Halt Command  [S] Suspend  [?] Help (default is "Y"): y

VERBOSE: Creating missing directory: C:\Backup
VERBOSE: Starting Step 2: Processing data payload.
Status: Processing data...

DEBUG: Total files discovered for processing: 2

Confirm
Continue with this operation?
[Y] Yes  [A] Yes to All  [H] Halt Command  [S] Suspend  [?] Help (default is "Y"): y

Attempting to create Resource Group rg-powershell-test in eastus ...

ResourceGroupName : rg-powershell-test
Location          : eastus
ProvisioningState : Succeeded

Success! Resource Group created successfully.
VERBOSE: Evaluating file: Document1.docx
VERBOSE: Evaluating file: Notes.txt
VERBOSE: Starting Step 3: Finalizing operations.
Status: Finalizing and cleaning up...

DEBUG: Closing open file handles and releasing resources.

Confirm
Continue with this operation?
[Y] Yes  [A] Yes to All  [H] Halt Command  [S] Suspend  [?] Help (default is "Y"): y

VERBOSE: Script execution completed successfully.
Status: Completed
Transcript stopped, output file is C:\powershell-advanced-tyler\LM1\ResourceGroupLog-20260901-074510.txt
**Observed Differances**: Verbose flows continuously without pausing. It prints the messages to the screen instantly while executing the code. Debug pauses the script automatically and prompts you for conformation before allowing the next line of code to execute. 

