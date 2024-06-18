function New-PolicyFile {
<#
.SYNOPSIS
Creates a new policy file with a randomly generated policy number and content.

.DESCRIPTION
The New-PolicyFile function creates a new policy file in the specified directory (`$Path`) or the current script's root directory if not specified. It generates a unique policy number prefixed with "PLY-" (customizable) and of a specified length. If the file already exists, it warns and retries unless `-Force` is specified. Once created, it populates the file with JSON-formatted policy data.

.PARAMETER Path
Specifies the directory path where the policy file will be created. Defaults to the current script's root directory.

.PARAMETER Prefix
Specifies the prefix for the policy number. Default prefix is "PLY-".

.PARAMETER Length
Specifies the length of the policy number (excluding the prefix). Default length is 9.

.PARAMETER Force
Indicates whether to overwrite the policy file if it already exists.

.EXAMPLE
New-PolicyFile
Creates a new policy file in the current script's root directory with a randomly generated policy number and default settings.

.EXAMPLE
New-PolicyFile -Path "C:\Policies" -Prefix "POL-" -Length 6 -Force
Creates a new policy file in "C:\Policies" with a policy number prefixed with "POL-" and of length 6. Overwrites existing files without prompting.

.NOTES
This function is designed to create simulated policy files for testing or demonstration purposes.
#>
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    param
    (
        [Parameter(Mandatory = $false)]
        [string] $Path = "$PSScriptRoot",

        [Parameter(Mandatory = $false)]
        [ValidateSet('PLY-')]
        [string] $Prefix = "PLY-",

        [Parameter(Mandatory = $false)]
        [ValidateRange(1,9)]
        [int] $Length = 9,

        [Parameter(Mandatory = $false)]
        [switch] $Force
    )
    begin {
    }
    process {
        do {
            $PolicyNumber = New-PolicyNumber -Prefix "PLY-" -Length 9
            if (Test-Path -Path "$Path\$($PolicyNumber).txt") {
                # Path exists
                Write-Warning -Message "Policy directory already existed at [$Path\$($PolicyNumber).txt]"
            } else {
                # Path does not exist
                $FullPolicyPath = "$Path\$($PolicyNumber).txt"
                Write-Verbose -Message "Creating policy file at [$Path\$($PolicyNumber).txt]"
                $PolicyFile = New-Item -Path $Path -Name "$($PolicyNumber).txt" -ItemType File -Force:$Force
                $PolicyData = New-PolicyData -PolicyNumber $PolicyNumber
                Write-Verbose -Message "Writing file contents to [$Path\$($PolicyNumber).txt] with policy content`n$PolicyData"
                $PolicyData | Out-File -FilePath "$Path\$($PolicyNumber).txt"
            }
        } while (!(Test-Path -Path "$Path\$($PolicyNumber).txt"))
    }
    end {
        Get-ChildItem -Path "$Path\$($PolicyNumber).txt"
    }
}