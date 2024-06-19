function Search-Files {
<#
.SYNOPSIS
Searches for files in a directory matching a specified pattern and returns matching lines.

.DESCRIPTION
The Search-Files function searches for files in the specified directory (`$Path`) that match the specified file extension (`$Extension`, default is "txt") and contain the specified pattern (`$Pattern`). It optionally searches recursively (`$Recurse`) into subdirectories up to a specified depth (`$Depth`). It returns lines from files that match the pattern, optionally all matches per file (`$ReturnAllMatches`).

.PARAMETER Path
Specifies the directory path where the search should begin.

.PARAMETER Pattern
Specifies the pattern to search for within the files.

.PARAMETER Extension
Specifies the file extension to filter files by. Default is "txt".

.PARAMETER ReturnAllMatches
Indicates whether to return all matches found in each file. If not specified, only the first match per file is returned.

.PARAMETER Recurse
Indicates whether to search recursively through subdirectories.

.PARAMETER Depth
Specifies the maximum number of subdirectory levels to recurse into.

.EXAMPLE
Search-Files -Path C:\temp\Policies -Pattern joh
Searches for files with a .txt extension in C:\temp\Policies, looking for lines containing the regex pattern "joh" and only the first match per file is returned

.EXAMPLE
Search-Files -Path C:\temp -Pattern joh -Recurse -Depth 1 -ReturnAll
earches for files with a .txt extension in C:\temp and its immediate subdirectories, looking for lines containing the word "TODO" and returns all matches per file.
#>
    param(
        [Parameter(Mandatory = $true)]
        [string] $Path,

        [Parameter(Mandatory = $true)]
        [string] $Pattern,

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string] $Extension = "txt",

        [Parameter(Mandatory = $false)]
        [switch] $ReturnAllMatches,

        [Parameter(Mandatory = $false, ParameterSetName="Recurse")]
        [switch] $Recurse,

        [Parameter(Mandatory = $false, ParameterSetName="Recurse")]
        [int] $Depth = 1
    )

    # Search for files in the directory matching the pattern
    $GetChildItemParameterObject = [ordered] @{
        Path = $Path
        File = $true
        Filter = "*.$Extension"
    }
    if($Recurse) {
        $GetChildItemParameterObject.Add("Recurse",$true)
        $GetChildItemParameterObject.Add("Depth", $Depth)
    }
    $Files = Get-ChildItem @GetChildItemParameterObject

    foreach ($File in $Files) {
        $PatternMatches = Select-String -Path $File -Pattern $Pattern -AllMatches
        if ($null -ne $PatternMatches) {
            if ($ReturnAllMatches) {
                $PatternMatches | Select-Object Path, LineNumber, Line
            } else {
                $PatternMatches[0] | Select-Object Path, LineNumber, Line
            }
        }
    }
}
