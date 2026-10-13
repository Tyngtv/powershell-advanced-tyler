Strengths of the New-TestResorceGroup Function:
-Allows the user to preview changes before deployment
-Catches typos
-Saves changes to a timestamp log
Improvements that could be made:
-The script searches the documents folder when not needed
-Possible permisions issues 
-could use Write-Verbose instead of Write-output

Both Resource groups where created successfully. 

I added Begin, process, and end to my function, I did this so I can create multiple resource groups at once. 

I added Write-Verbose throughout my function that will provide messages to the user for Function start, Validation Success, Resource group creation and Successful completion

In Task 5, 3 objects where processed witch where the three IDs I put in. They were all successfully created with no errors. 

