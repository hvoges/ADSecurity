# Add the required .NET namespaces
Add-Type -AssemblyName System.DirectoryServices
Add-Type -AssemblyName System.Security

# Specify the LDAP path to the AD object
$ldapPath = "LDAP://DC=bitweise,DC=de"

# Create a new DirectoryEntry object
$directoryEntry = New-Object System.DirectoryServices.DirectoryEntry($ldapPath)

# Get the security descriptor
$securityDescriptor = $directoryEntry.ObjectSecurity

# Enumerate the access rules
foreach ($accessRule in $securityDescriptor.GetAccessRules($true, $true, [System.Security.Principal.NTAccount])) {
    [PSCustomObject]@{    
        IdentityReference = $($accessRule.IdentityReference)
        AccessControlType = $($accessRule.AccessControlType)
        ActiveDirectoryRights = $($accessRule.ActiveDirectoryRights)
        InheritanceType = $($accessRule.InheritanceType)
        ObjectType = $($accessRule.ObjectType)
        IsInherited = $($accessRule.IsInherited)
    }
}
