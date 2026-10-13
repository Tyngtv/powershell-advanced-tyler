# Documentation 

## Configuration Name
- CompanyBaseline

## Node
- localhost

## Resource 1
- File AutomationFolder Witch makes sure the directory exists.

## Resource 2
-File ConfigFile witch ensures C:\Automation\Config.txt exists with the contents NWTC Standard Configuration. Type = "File". It also identifies it as a file, and Ensure = "Present" tells DSC to create it if it’s missing.

