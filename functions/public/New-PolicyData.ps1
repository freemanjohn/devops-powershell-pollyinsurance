
function New-PolicyData {
<#
.SYNOPSIS
Creates new policy data with randomly generated names and addresses.

.DESCRIPTION
The New-PolicyData function generates policy data with random names and addresses. It accepts a PolicyNumber parameter and optionally allows customization of GivenNames, Surnames, and Addresses arrays.

.PARAMETER PolicyNumber
Specifies the policy number associated with the generated policy data.

.PARAMETER GivenNames
Specifies an array of given names to randomly select from. Default names include common English names.

.PARAMETER Surnames
Specifies an array of surnames to randomly select from. Default surnames include common English last names.

.PARAMETER Addresses
Specifies an array of addresses to randomly select from. Default addresses include fictional street addresses.

.EXAMPLE
New-PolicyData -PolicyNumber "PLY-123456789"
Generates policy data with the policy number "PLY-123456789", using default arrays for names and addresses.

.EXAMPLE
New-PolicyData -PolicyNumber "P54321" -GivenNames @("Alice", "Bob") -Surnames @("Doe", "Smith") -Addresses @("456 Elm St", "789 Oak St")
Generates policy data with the policy number "P54321", using custom arrays for names and addresses.

.NOTES
This function generates random policy data for testing and demonstration purposes.
#>
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    param
    (
        [Parameter(Mandatory = $true)]
        [string] $PolicyNumber,

        [Parameter(Mandatory = $false)]
        [array] $GivenNames = @('John', 'Mary', 'James', 'Jennifer', 'Robert', 'Linda', 'Michael', 'Elizabeth', 'William', 'Patricia', 'David', 'Barbara', 'Richard', 'Susan', 'Joseph', 'Jessica', 'Charles', 'Sarah', 'Thomas', 'Karen'),

        [Parameter(Mandatory = $false)]
        [array] $Surnames = @('Smith', 'Johnson', 'Williams', 'Jones', 'Brown', 'Davis', 'Miller', 'Wilson', 'Moore', 'Taylor', 'Anderson', 'Thomas', 'Jackson', 'White', 'Harris', 'Martin', 'Thompson', 'Garcia', 'Martinez', 'Robinson', 'Clark', 'Rodriguez', 'Lewis', 'Lee', 'Walker', 'Hall'),

        [Parameter(Mandatory = $false)]
        [array] $Addresses = @(
                    '123 Main St', '456 Elm St', '789 Oak St', '321 Pine St', '555 Maple Ave',
                    '111 First St', '222 Second St', '333 Third St', '444 Fourth St', '555 Fifth St',
                    '666 Sixth St', '777 Seventh St', '888 Eighth St', '999 Ninth St', '000 Tenth St',
                    '777 Elm St', '888 Oak St', '999 Pine St', '000 Maple Ave', '111 Main St',
                    '123 First Ave', '456 Second Ave', '789 Third Ave', '321 Fourth Ave', '555 Fifth Ave',
                    '666 Sixth Ave', '777 Seventh Ave', '888 Eighth Ave', '999 Ninth Ave', '000 Tenth Ave',
                    '777 Elm Ave', '888 Oak Ave', '999 Pine Ave', '000 Maple Ave', '111 Main Ave',
                    '123 First Rd', '456 Second Rd', '789 Third Rd', '321 Fourth Rd', '555 Fifth Rd',
                    '666 Sixth Rd', '777 Seventh Rd', '888 Eighth Rd', '999 Ninth Rd', '000 Tenth Rd',
                    '777 Elm Rd', '888 Oak Rd', '999 Pine Rd', '000 Maple Rd', '111 Main Rd'
                )
    )

    begin {}
    process {
        # Generate random policies
        $GivenName = Get-Random -InputObject $GivenNames
        $Surname = Get-Random -InputObject $Surnames
        $Address = Get-Random -InputObject $Addresses

        $Policy = [PSCustomObject]@{
            GivenName = $GivenName
            Surname = $Surname
            FullName = "$GivenName $Surname"
            Address = $Address
            PolicyNumber = $PolicyNumber
        } | ConvertTo-Json

        $Policy
    }
    end {
    }
}
