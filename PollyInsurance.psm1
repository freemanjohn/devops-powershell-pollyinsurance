$FunctionArray = @()
$Directories = @("public", "private")

foreach ($Directory in $Directories) {
    foreach ($Function in $(Get-ChildItem -Path "$($PSScriptRoot)\functions\$Directory" -Filter "*.ps1" -Recurse)) {
        Write-Verbose -Message "Processing function [$Function]"
        $PSObject = New-Object -Type PSObject
        $PSObject | Add-Member -MemberType NoteProperty -Name "Scope" -Value "$Directory"
        $PSObject | Add-Member -MemberType NoteProperty -Name "FunctionName" -Value "$($Function.Name)"
        $PSObject | Add-Member -MemberType NoteProperty -Name "FunctionFullName" -Value "$($Function.FullName)"
        $PSObject | Add-Member -MemberType NoteProperty -Name "FunctionBaseName" -Value "$($Function.BaseName)"
        $FunctionArray += $PSObject
    }
}

foreach ($Function in $FunctionArray) {
    try {
        . $Function.FunctionFullName
    } catch {
        Write-Error -Message "Failed to import function [$($Function.FunctionFullName)]" -ErrorAction Stop
    }
}

Export-ModuleMember -Alias * -Function $($FunctionArray | Where-Object {$_.Scope -like "public"}).FunctionBaseName