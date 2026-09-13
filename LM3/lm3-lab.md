In this lab I Converted a script to function by using the (new-testresourcegroup) command. I also Enabled Cmdlet Capabilities by adding CmdletBinding. I added Parameter validation by introducing Hashtable perameter with the $tags name.  

I also configured the pipeline input by updating the $ResourceGroupName parameter with ValueFromPipeline so the function can accept the process string inputs. And I also implemented Whatif/confirm that would allow admins to safely test execution using -whatif and -confrim swtiches. 
