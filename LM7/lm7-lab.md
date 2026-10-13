# Documentation 

## Configuration Name
- CompanyBaseline

## Node
- localhost

## Resource 1
- File AutomationFolder Witch makes sure the directory exists.

## Resource 2
-File ConfigFile witch ensures C:\Automation\Config.txt exists with the contents NWTC Standard Configuration. Type = "File". It also identifies it as a file, and Ensure = "Present" tells DSC to create it if it’s missing.

# My DSC Documentation

## File Location
C:\GitHub\powershell-advanced-tyler\DSC\lm7-dsc.ps1

## File Purpose
-This script targets the local machine, node host and ensures the Windows Web Server feature is installed and enabled. 

## Information Observed
Config name: TylerBaseline
Node: localhost
Resource Type: WindowsFeature
Desired State: Present
Import statement: Import-DscResource -ModuleName PSDscResources