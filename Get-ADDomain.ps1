# Load the System.DirectoryServices.Protocols assembly
Add-Type -AssemblyName System.DirectoryServices.Protocols

# Define LDAP connection parameters
$ldapServer = "dc1.bitweise.de" # Replace with your domain controller
$ldapConnection = New-Object System.DirectoryServices.Protocols.LdapConnection($ldapServer)

# Optional: Set credentials if required
# $networkCredential = New-Object System.Net.NetworkCredential("username", "password", "domain")
# $ldapConnection.Credential = $networkCredential

# Connect to the LDAP server
$ldapConnection.Bind()

# Define search parameters
$searchBase = "DC=bitweise,DC=de" # Replace with your domain's DN
$searchFilter = "(objectClass=domain)"
$searchRequest = New-Object System.DirectoryServices.Protocols.SearchRequest($searchBase, $searchFilter, "Subtree", @("distinguishedName"))

# Perform the search
$searchResponse = $ldapConnection.SendRequest($searchRequest)

# Output the results
foreach ($entry in $searchResponse.Entries) {
    Write-Host "DN: $($entry.DistinguishedName)"
}

# Optional: Dispose of the LDAP connection
$ldapConnection.Dispose()
