 <#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Tracey B
    LinkedIn        : linkedin.com/in/tleanne/
    GitHub          : github.com/tleanne1
    Date Created    : 2025-03-10
    Last Modified   : 2025-03-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

# YOUR CODE GOES HERE

# Define the registry path
$registryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application'

# Define the property name and desired value
$propertyName = 'MaxSize'
$desiredValue = 32768  # 32,768 KB

# Check if the registry key exists; if not, create it
if (-not (Test-Path -Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Check if the property exists and has the desired value
$currentValue = Get-ItemProperty -Path $registryPath -Name $propertyName -ErrorAction SilentlyContinue

if ($null -eq $currentValue) {
    # Property does not exist; create it with the desired value
    New-ItemProperty -Path $registryPath -Name $propertyName -Value $desiredValue -PropertyType DWord -Force | Out-Null
} elseif ($currentValue.$propertyName -ne $desiredValue) {
    # Property exists but does not have the desired value; update it
    Set-ItemProperty -Path $registryPath -Name $propertyName -Value $desiredValue -Force
} 
