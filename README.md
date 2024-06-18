# devops-powershell-pollyinsurance
- .nuspec file and .psd1 have variables referenced that have to be replaced when building the package for this module.

## Creating environment for testing
```
$Path = "C:\temp\Policies"
Import-Module .\PollyInsurance.psm1
Get-ChildItem -Path C:\temp\
1..30 | foreach-object {New-PolicyFile -Path $Path -Verbose -Force}

# Return a single result per file
Search-Files -Path $Path -Pattern "joh"

# Return all results per file
Search-Files -Path $Path -Pattern "joh" -ReturnAll
```