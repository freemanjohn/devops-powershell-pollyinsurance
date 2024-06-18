function New-PolicyNumber
{
<#
.SYNOPSIS
Generates a new policy number with a specified prefix and length.

.DESCRIPTION
The New-PolicyNumber function generates a new policy number by appending a random number (between 1 and 123456789) with leading zeros to match the specified length. It prefixes the generated number with a customizable prefix (default is "PLY-").

.PARAMETER Prefix
Specifies the prefix for the policy number. Default prefix is "PLY-".

.PARAMETER Length
Specifies the length of the policy number (excluding the prefix). Default length is 9.

.EXAMPLE
New-PolicyNumber
Generates a new policy number with the default prefix "PLY-" and length 9.

.EXAMPLE
New-PolicyNumber -Prefix "PLY-" -Length 6
Generates a new policy number with the prefix "PLY-" and length 6.

.NOTES
This function is designed to generate policy numbers for use in creating policy files or similar scenarios.
#>
    [CmdletBinding()]
    [Alias()]
    [OutputType([string])]
    param
    (
        [Parameter(Mandatory = $false)]
        [ValidateSet('PLY-')]
        [string] $Prefix = "PLY-",

        [Parameter(Mandatory = $false)]
        [ValidateRange(1,9)]
        [int] $Length = 9
    )
    begin {
    }
    process {
        $PolicyNumber = $(Get-Random -Minimum 1 -Maximum 123456789).ToString()
        while ($PolicyNumber.Length -lt 9) {
            Write-Verbose -Message "Adding leading zero to policy number generated [$PolicyNumber]"
            $PolicyNumber = "0" + "$PolicyNumber"
        }
        $PolicyNumber = $Prefix + $PolicyNumber
    }
    end {
        $PolicyNumber
    }
}